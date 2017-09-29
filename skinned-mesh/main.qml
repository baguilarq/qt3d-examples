/****************************************************************************
**
** Copyright (C) 2017 Klaralvdalens Datakonsult AB (KDAB).
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt3D module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import Qt3D.Core 2.10
import Qt3D.Render 2.10
import Qt3D.Input 2.0
import Qt3D.Animation 2.10
import Qt3D.Extras 2.10
import QtQuick 2.9

DefaultSceneEntity {
    id: scene

    SkinnedPbrEffect {
        id: skinnedPbrEffect
    }

    SimpleEntity {
        id: simpleEntity
        transform.translation: Qt.vector3d(-4.0, 0.0, 0.0);
        source: "qrc:/assets/gltf/2.0/Robot/robot.gltf"
        baseColor: "blue"
    }

    Timer {
        interval: 2000
        running: true
        repeat: false
        onTriggered: {
            animator1.running = true
            animator2.running = true
        }
    }

    SkinnedEntity {
        id: riggedFigure1
        effect: skinnedPbrEffect
        source: "qrc:/assets/gltf/2.0/Robot/robot.gltf"
        baseColor: "orange"
        transform.scale: 0.035;
        transform.translation: Qt.vector3d(0.0, 3.33, 0.0);

        components: [
            BlendedClipAnimator {
                id: animator1
                loops: 100
                blendTree: ClipBlendValue {
                    clip: AnimationClipLoader { source: "qrc:/assets/gltf/2.0/Robot/walk.json" }
                }
                channelMapper: ChannelMapper {
                    mappings: [
                        SkeletonMapping { skeleton: riggedFigure1.skeleton }
                    ]
                }

                onRunningChanged: console.log("running = " + running)
            }
        ]
    }

    SkinnedEntity {
        id: riggedFigure2
        effect: skinnedPbrEffect
        source: "qrc:/assets/gltf/2.0/Robot/robot.gltf"
        baseColor: "green"
        transform.scale: 0.035;
        transform.translation: Qt.vector3d(5.0, 3.33, 0.0);

        components: [
            BlendedClipAnimator {
                id: animator2
                loops: 100
                blendTree: ClipBlendValue {
                    clip: AnimationClipLoader { source: "qrc:/assets/gltf/2.0/Robot/samba.json" }
                }
                channelMapper: ChannelMapper {
                    mappings: [
                        SkeletonMapping { skeleton: riggedFigure2.skeleton }
                    ]
                }

                onRunningChanged: console.log("running = " + running)
            }
        ]
    }
}
