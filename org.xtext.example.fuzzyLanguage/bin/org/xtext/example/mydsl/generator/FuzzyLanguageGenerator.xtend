/*
 * generated by Xtext 2.16.0
 */
package org.xtext.example.mydsl.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.emf.ecore.EObject
import org.xtext.example.mydsl.fuzzyLanguage.TypeSet
import org.xtext.example.mydsl.fuzzyLanguage.Binding
import org.xtext.example.mydsl.fuzzyLanguage.FuzzyConfig
import org.eclipse.emf.common.util.EList
import org.xtext.example.mydsl.fuzzyLanguage.FuzzyModel
import org.xtext.example.mydsl.fuzzyLanguage.impl.TypeSetImpl
import org.xtext.example.mydsl.fuzzyLanguage.impl.FuzzyConfigImpl
import org.xtext.example.mydsl.fuzzyLanguage.impl.BindingImpl
import org.xtext.example.mydsl.fuzzyLanguage.impl.FuzzyModelImpl
import org.xtext.example.mydsl.fuzzyLanguage.Param
import org.xtext.example.mydsl.fuzzyLanguage.FuzzySystemBuilding
import org.xtext.example.mydsl.fuzzyLanguage.Affectation
import org.xtext.example.mydsl.fuzzyLanguage.impl.FuzzySystemBuildingImpl
import org.xtext.example.mydsl.fuzzyLanguage.Expression
import java.util.ArrayList
import org.xtext.example.mydsl.fuzzyLanguage.Outputs
import org.xtext.example.mydsl.fuzzyLanguage.impl.OutputsImpl

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class FuzzyLanguageGenerator extends AbstractGenerator {

	ArrayList<String> ids=new ArrayList<String>();
	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		fsa.generateFile(
			"FuzzyMain.cpp",resource.compile
		)
	}
	var Type=""
	
	def CharSequence compile(Resource resource){
		'''
			#include <iostream>
			#include <fstream>
			#include "ExpressionFactory.h"
			#include "CogDefuzz.h"
			#include "FuzzyFactory.h"
			#include "IsRamp.h"
			#include "IsGaussian.h"
			#include "IsTrapeze.h"
			#include "IsTriangle.h"
			#include "AndMin.h"
			#include "OrPlus.h"
			#include "OrMax.h"
			#include "ThenMin.h"
			#include "AggPlus.h"
			#include "NotMinus1.h"
			#include "AggMax.h"
			
			using namespace Core;
			using namespace Fuzzy;
			using namespace std;
			
			int main(){
				�FOR EObject obj:resource.contents��obj.compile��ENDFOR�
				return 0;
			}
			
		'''
	}
	def CharSequence compile(EObject obj){
		switch(obj){
			TypeSet:
				(obj as TypeSetImpl).compile
			Binding:
				(obj as BindingImpl).compile
			FuzzyConfig:
				(obj as FuzzyConfigImpl).compile
			FuzzySystemBuildingImpl:
				(obj as FuzzySystemBuildingImpl).compile
			FuzzyModel:
				(obj as FuzzyModelImpl).compile
			Outputs:
				(obj as OutputsImpl).compile	
		}	
	}
	
	def CharSequence compile(OutputsImpl out){
		if(out.out.path === null ){
			if(ids.contains(out.wr.value)){
				'''
				cout << "�out.wr.value� ->" << �out.wr.value�->evaluate()<< endl;'''
			}
			else {
				'''
				cout << "�out.wr.value� ->"<<&�out.wr.value�->evaluate()<< endl;'''
			}
		}
		else{
			if(ids.contains(out.wr.value)){
				'''
				ofstream file (�out.out.path�);
				file<<"�out.wr.value� ->"<<�out.wr.value�->evaluate();
				file.close();
				'''
			}
			else {
				'''
				ofstream file (�out.out.path�);
				file<<"�out.wr.value� ->"<<�out.wr.value�->evaluate();
				file.close();
				'''
			}
		}
			
	}
	
	def CharSequence compile(FuzzyModel fm){
		'''
			�FOR EObject element : fm.eContents��element.compile��ENDFOR�
		'''
	}
	
	def CharSequence compile(FuzzyConfigImpl impl){
		var contents=impl.eContents

		'''
			�FOR EObject obj : contents�
				�obj.compile�
			�ENDFOR�
			SugenoDefuzz<float> opSugenoDefuzz;	
			FuzzyFactory<�Type�> f((And<�Type�>*) &opAnd, (Or<�Type�>*)&opOr, (Then<�Type�>*)&opThen, (Agg<�Type�>*)&opAgg, &opDefuzz, (Not<�Type�>*)&opNot, &opSugenoDefuzz );
			
		'''
		
	}
	
	def CharSequence compile(TypeSetImpl impl){
		Type=impl.typeName
		
		'''
		'''
	}
	def CharSequence compile(FuzzySystemBuildingImpl fsb){
		
		'''
		�FOR affectation : fsb.affectations��(affectation as Affectation).compile��ENDFOR�
		'''
	}
	
	def CharSequence compile(Affectation af){
		if(af.exp !==null){
			ids.add(af.name)
			return 
			'''
			Expression<�Type�>* �af.name� = �af.exp.compile�;
			'''
		}
		if(af.params.size==0 && af.value!="ASK_USER_FOR_VALUE"){
			return '''ValueModel<�Type�> �af.name�(�af.value�);'''
		}
		else{
			switch(af.value){
				case("Gaussian"):
					return '''
					IsGaussian<�Type�> �af.name.toString�(�af.params.get(0).value�,�af.params.get(1).value�);
					'''
				case("Trapeze"):
					return '''
					IsTrapeze<�Type�> �af.name.toString�(�af.params.get(0).value�, �af.params.get(1).value�, �af.params.get(2).value�, �af.params.get(3).value�, concavite::�af.params.get(4).value�);
					'''
				case("Triangle"):
					return '''
					IsTriangle<�Type�> �af.name.toString�(�af.params.get(0).value�, �af.params.get(1).value�, �af.params.get(2).value�);
					'''
				case("Ramp"):
					return '''
					IsRamp<�Type�> �af.name�(�af.params.get(0).value�, �af.params.get(1).value�, IsRamp<�Type�>::dir::�af.params.get(2).value�);
					'''
				case("ASK_USER_FOR_VALUE"):
					'''
					�Type� value;
					cout << "�af.name� : ";
					cin >> value;
					ValueModel<�Type�> �af.name�(value);

					'''
			}
		}
	}
	
	def CharSequence compile(Expression exp){
		if(exp.value!==null){
			if(ids.contains(exp.name)){
				'''f.newIs(�exp.value.compile�, �exp.name� )'''
			}
			else{
			'''f.newIs(�exp.value.compile�, &�exp.name� )'''
			}
		}
		else{
			if(exp.exps.size==0){
				if(ids.contains(exp.name))
					'''�exp.name�'''
				else{
					'''&�exp.name�'''
				}
			}
			else{
			'''
			f.new�exp.name.toLowerCase.toFirstUpper�(�FOR Expression ex: exp.exps��IF ex==exp.exps.last��ex.compile��ELSE��ex.compile�,�ENDIF��ENDFOR�)'''
			}
		}
	}
	def CharSequence compile(BindingImpl impl){
		var op=""
		switch(impl.op){
			case "NOT": op= "opNot"
			case "AND": op= "opAnd"
			case "OR": op = "opOr"
			case "DEFUZZ": op = "opDefuzz"
			case "THEN": op = "opThen"
			case "AGG": op = "opAgg"
			
		}
		if(impl.params.size==0){
			'''�impl.target�<�Type�> �op�;'''
		}
		else{
			'''�impl.target�<�Type�> �op� (�FOR Param p : impl.params��IF p==impl.params.last��p.value��ELSE��p.value�,�ENDIF��ENDFOR�);'''
		}
	}

	
	def CharSequence compile (EList<BindingImpl> bindings){
		'''
			(�FOR Binding binding: bindings ��binding.compile��ENDFOR�)
		'''
	}
}