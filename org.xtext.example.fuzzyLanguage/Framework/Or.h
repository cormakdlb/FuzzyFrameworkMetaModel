#pragma once
#include "BinaryExpression.h"

using namespace Core;

namespace Fuzzy {
	template <class T>
	class Or :public BinaryExpression<T> {
	public:
		virtual T evaluate(Expression<T>*, Expression<T>*) const = 0;
	};
}