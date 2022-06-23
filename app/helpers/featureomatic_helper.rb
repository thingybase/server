module FeatureomaticHelper
  def feature_maximum(limit, feature)
    if limit.maximum.infinite?
      feature_unlimited feature
    else
      pluralize limit.maximum, feature
    end
  end

  def feature_quantity(limit, feature)
    if limit.quantity.infinite?
      feature_unlimited feature
    else
      pluralize limit.quantity, feature
    end
  end

  def feature_unlimited(singular)
    "unlimited #{singular.pluralize}"
  end
end
