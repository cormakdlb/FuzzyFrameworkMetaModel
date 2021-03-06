/**
 * generated by Xtext 2.16.0
 */
package org.xtext.example.mydsl.ide;

import com.google.inject.Guice;
import com.google.inject.Injector;
import org.eclipse.xtext.util.Modules2;
import org.xtext.example.mydsl.FuzzyLanguageRuntimeModule;
import org.xtext.example.mydsl.FuzzyLanguageStandaloneSetup;
import org.xtext.example.mydsl.ide.FuzzyLanguageIdeModule;

/**
 * Initialization support for running Xtext languages as language servers.
 */
@SuppressWarnings("all")
public class FuzzyLanguageIdeSetup extends FuzzyLanguageStandaloneSetup {
  @Override
  public Injector createInjector() {
    FuzzyLanguageRuntimeModule _fuzzyLanguageRuntimeModule = new FuzzyLanguageRuntimeModule();
    FuzzyLanguageIdeModule _fuzzyLanguageIdeModule = new FuzzyLanguageIdeModule();
    return Guice.createInjector(Modules2.mixin(_fuzzyLanguageRuntimeModule, _fuzzyLanguageIdeModule));
  }
}
