/**
 * generated by Xtext 2.16.0
 */
package org.xtext.example.mydsl;

import org.xtext.example.mydsl.FuzzyLanguageStandaloneSetupGenerated;

/**
 * Initialization support for running Xtext languages without Equinox extension registry.
 */
@SuppressWarnings("all")
public class FuzzyLanguageStandaloneSetup extends FuzzyLanguageStandaloneSetupGenerated {
  public static void doSetup() {
    new FuzzyLanguageStandaloneSetup().createInjectorAndDoEMFRegistration();
  }
}