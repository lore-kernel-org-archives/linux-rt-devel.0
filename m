Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F91BCA1C
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576648; cv=none; b=gfZhT+DkMrwzABWoBvHFBwZRl2SUnecdSzyUIuoBfOfwgxKPjqU4mN8lRGBus3Py9OcvGOaG8xO10HTJF59mHYS9bigAkz1XXic4zvKs+c3XxGY3AB5ByOfvDIowNdBzM6tawWyZw3IsAWACsv/s7Q8o7048RhD4rdP6/ww6I+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576648; c=relaxed/simple;
	bh=exUvLgPm2x9wuI/aDrTue0KanKuqh/I0IRpyx2LbQuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ake7RTxk8w9dpRCSrOkjYKX1atKaXR0eHVaUyzzm4JjLZ+ToNWBfRDTpENM7gNHBxk5HFPz8gP60Uc9z6rFXE1rpQ3sQtE5roJ3eOZfFqvg9VbCphkwyO+TLXKv8zsEucZ+JF/AgZ/+f62at5o5Dz6h8v9znG7Pm4BGyjB9yVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=V0O01D/A; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="V0O01D/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576645;
	bh=exUvLgPm2x9wuI/aDrTue0KanKuqh/I0IRpyx2LbQuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0O01D/AJsu8hM4gFkyOBO3rBNw5iX5m8nGUsrmNCu/l3NjS/P9a62+B6pVYdosm4
	 o8HMi9VWlwsk81TNsUnm+OAyLdoVC3a2zLkB5K0D8cdo2PzRp4n2AJqcw6Pr9fw4Fv
	 t4NwEV45Nt5I4+kkKV7jrLx9Z8eV6gCGg5DUajb/oNOQKJo//gvtpawDOOKZ9kJDdG
	 Ns0tBmcG9wKAltMEw3lnc1C8c6sV2Zks7aPkc1aJfsAuvWOpdb8uKaYZm5baaFSRIb
	 2wJIZzGZS3kyBFsq8YwbcKKjyx+cS3YxIgH+5LI4B3qykIc+Q18/g81GxxL4xDWAvL
	 jNLpLN9h0r/nA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>,
	Uma Shankar <uma.shankar@intel.com>
Subject: [i915-rt v6 11/24] drm/i915/display: Make icl_dsi_frame_update use _fw too
Date: Fri, 20 Feb 2026 09:37:09 +0100
Message-ID: <20260220083657.28815-37-dev@lankhorst.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220083657.28815-26-dev@lankhorst.se>
References: <20260220083657.28815-26-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't use the dmc lock inside the vblank critical section,
not even as last call.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index 7cf511a6c0f95..52e1d45c63162 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -242,8 +242,8 @@ void icl_dsi_frame_update(struct intel_crtc_state *crtc_state)
 	else
 		return;
 
-	intel_de_rmw(display, DSI_CMD_FRMCTL(port), 0,
-		     DSI_FRAME_UPDATE_REQUEST);
+	intel_de_rmw_fw(display, DSI_CMD_FRMCTL(port), 0,
+			DSI_FRAME_UPDATE_REQUEST);
 }
 
 static void dsi_program_swing_and_deemphasis(struct intel_encoder *encoder)
-- 
2.51.0

