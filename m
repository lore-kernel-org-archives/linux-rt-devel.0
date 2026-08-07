Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DC43B3DE
	for <linux-rt-devel@lists.linux.dev>; Fri,  7 Aug 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107539; cv=none; b=M25H9VJjffgAnpeoGmJxzFfyWAEdV1iCZskSBWMA1++PxtgL3SBvfkTm5v/7bUKbJQNTLMFS5quFtXwPk/vyBe9Bh/WVSEtq9fvWGNKSKlH7MJUz3l4hlThDIvApp8TeGoM3z/n7V4aEJru7vL32M+DHpddwFpS/9nsSvl7G+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107539; c=relaxed/simple;
	bh=Rt5ZaNrVPAr3BZJ6WD5LCtPvNqbzd3J7TFJYMIWpB2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkHNrbrJ6qPpaGyUMe1xDZWiN7jiMw/gwDvjd2mWPv4EKzoTfTaSY1QacO17DIBNWA3SEnLh9nTCDgqV1/6khtIo/tMZwz8Yg8idzrepsTOcrsjXKEHsfp3t/nN05U2OlyzZRAiMRxy1FRHZXaydI5gWIJ5owWjyWHYnXT67YCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=tNvHCWAd; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="tNvHCWAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786107514; x=1786712314; i=spasswolf@web.de;
	bh=MmwwpNoMGIhDUf7hvVu+UCgXO5AbAdc1YbxjVMQy2fo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tNvHCWAdVU/JsVir3JpHoViwoRiUzGm6px0hJERHkF1+8UdER3U6kmkpB4mHbVXq
	 bbpbaymVjrg+rwTRu3+X0nkmYm+IN4wx8OLpIRFbzJnROjDKJHvgKmWT+Q5Y8n+dW
	 pX/OICduvjIZpXhicpxtqYvctjtc59lqsQO8STLfoF9mQPHHgPbnpluuF4Stu6w2E
	 uOr+cD2yHy/HO9vNoWMSj6pklr6cAaWVNfjNp/iErhb/+Ti+GTWNbGe8IIzISfFXs
	 B3jyqzA8JdTOceODZ6tqJTd/IK4gznIs9L7FNuezm8tKt/gp2fSSBuk6VjG9Abc4Y
	 VPwYKNS4gAWLbh4L7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HFy-1wq7E206vo-001xNT; Fri, 07
 Aug 2026 14:58:34 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
Date: Fri,  7 Aug 2026 14:58:31 +0200
Message-ID: <20260807125832.157856-1-spasswolf@web.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CABXGCsMFa25HyOdcSX8QR8_=58=uJT+HMVhyus=rOFHBML25=w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4kkU/Ay0SXFKTO8mnJmp/HIuZVygmRfN6wRXkjbSdXb6tb/54Zr
 CQe6j5Knl8HJ5RaJL27U+XeMAjRaUdmnu+fTKjUw5dfvvzr/bzZoDx5ws5Xx1WcPvv3/qoF
 QVh1zwvJqaYpuUIwXzHV10ggJTWHdJRTUV2zpQgI/TEoCbRMjcxaC/DgjJpYh1abreL21HG
 DLfACgfB+v1OPAP9EONcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ldkNcjNvJ6k=;YtznG3/Tc9yw+SxHG4uzSB4dWkh
 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

On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
converted to rt_mutex. dc_create_plane_state() can be called while
inside an FPU-guarded region, resuling in "scheduling while atomic"
errors on PREEMPT_RT kernels.
 Fix this by calling kvzalloc_obj() with DC_RUN_WITH_PREEMPTION_ENABLED().
Also fix the error path in dc_create_stream_for_sink().

Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Pa=
rt 1")
Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_stream.c
index cdcf140bc1bb..accad9e20e88 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -229,7 +229,7 @@ struct dc_stream_state *dc_create_stream_for_sink(
=20
 fail:
 	if (stream)
-		kfree(stream);
+		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
=20
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_surface.c
index 88e825a6582c..f4eb021711cb 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -33,6 +33,7 @@
 #include "dpp.h"
=20
 #include "dc_plane_priv.h"
+#include "dc_fpu.h"
=20
 /************************************************************************=
*******
  * Private functions
@@ -85,8 +86,8 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_stat=
e, const struct dc_plane
  ************************************************************************=
******/
 struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
 {
-	struct dc_plane_state *plane_state =3D kvzalloc_obj(*plane_state,
-							  GFP_ATOMIC);
+	struct dc_plane_state *plane_state;
+	DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D kvzalloc_obj(*plane_state=
, GFP_ATOMIC));
=20
 	if (NULL =3D=3D plane_state)
 		return NULL;
=2D-=20
2.55.0

Added compile fix (by Mikhail Gavrilov) for CONFIG_DRM_AMD_DC_FP=3Dn to
the patch for linux-next. Compile tested with arm64/clang on debian sid.

Bert Karwatzki
