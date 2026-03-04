local v1 = {
    ["Head"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = 0,
        ["TwistUpperAngle"] = 0,
        ["Restitution"] = 0,
        ["UpperAngle"] = 1
    },
    ["UpperTorso"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = -3,
        ["TwistUpperAngle"] = 3,
        ["Restitution"] = 0,
        ["UpperAngle"] = 5
    },
    ["LowerTorso"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = -5,
        ["TwistUpperAngle"] = 5,
        ["Restitution"] = 0,
        ["UpperAngle"] = 8
    },
    ["LeftLowerArm"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = -5,
        ["TwistUpperAngle"] = 5,
        ["Restitution"] = 0.05,
        ["UpperAngle"] = 25
    },
    ["RightLowerArm"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = -5,
        ["TwistUpperAngle"] = 5,
        ["Restitution"] = 0.05,
        ["UpperAngle"] = 25
    },
    ["LeftHand"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = 0,
        ["TwistUpperAngle"] = 0,
        ["Restitution"] = 0,
        ["UpperAngle"] = 0
    },
    ["RightHand"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = 0,
        ["TwistUpperAngle"] = 0,
        ["Restitution"] = 0,
        ["UpperAngle"] = 0
    },
    ["LeftUpperLeg"] = {
        ["ConstraintType"] = "Hinge",
        ["LimitsEnabled"] = true,
        ["LowerAngle"] = -25,
        ["UpperAngle"] = 25,
        ["Restitution"] = 0
    },
    ["RightUpperLeg"] = {
        ["ConstraintType"] = "Hinge",
        ["LimitsEnabled"] = true,
        ["LowerAngle"] = -25,
        ["UpperAngle"] = 25,
        ["Restitution"] = 0
    },
    ["LeftLowerLeg"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = -5,
        ["TwistUpperAngle"] = 5,
        ["Restitution"] = 0,
        ["UpperAngle"] = 20
    },
    ["RightLowerLeg"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = -5,
        ["TwistUpperAngle"] = 5,
        ["Restitution"] = 0,
        ["UpperAngle"] = 20
    },
    ["LeftFoot"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = -5,
        ["TwistUpperAngle"] = 5,
        ["Restitution"] = 0,
        ["UpperAngle"] = 15
    },
    ["RightFoot"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = -5,
        ["TwistUpperAngle"] = 5,
        ["Restitution"] = 0,
        ["UpperAngle"] = 15
    },
    ["LeftUpperArm"] = {
        ["ConstraintType"] = "Hinge",
        ["LimitsEnabled"] = true,
        ["LowerAngle"] = -30,
        ["UpperAngle"] = 30,
        ["Restitution"] = 0.05
    },
    ["RightUpperArm"] = {
        ["ConstraintType"] = "Hinge",
        ["LimitsEnabled"] = true,
        ["LowerAngle"] = -30,
        ["UpperAngle"] = 30,
        ["Restitution"] = 0.05
    },
    ["Default"] = {
        ["TwistLimitsEnabled"] = true,
        ["LimitsEnabled"] = true,
        ["TwistLowerAngle"] = -15,
        ["TwistUpperAngle"] = 15,
        ["Restitution"] = 0.05,
        ["UpperAngle"] = 30
    }
}
return table.freeze(v1)