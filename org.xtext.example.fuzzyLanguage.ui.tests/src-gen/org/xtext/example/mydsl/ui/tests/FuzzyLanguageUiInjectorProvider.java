/*
 * generated by Xtext 2.16.0
 */
package org.xtext.example.mydsl.ui.tests;

import com.google.inject.Injector;
import org.eclipse.xtext.testing.IInjectorProvider;
import org.xtext.example.fuzzyLanguage.ui.internal.FuzzyLanguageActivator;

public class FuzzyLanguageUiInjectorProvider implements IInjectorProvider {

	@Override
	public Injector getInjector() {
		return FuzzyLanguageActivator.getInstance().getInjector("org.xtext.example.mydsl.FuzzyLanguage");
	}

}
