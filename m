Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AAF26FA6F
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576666; cv=none; b=rZZAsWZmaZjej1dItu0BPEFZsZ4Sg36+ZrIbJrJcv0RfHiSwX4I2uRyjkSGsvdJmCxajYFi9IUVUgsF3TYpKu/UB3zGqg/yseY7z/dlamqWE9MtI2DPOBaWewoAOSI+Z/HO0EFJkHk5uxCkvJybftjgu2hCGllba7aV+pzG7aMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576666; c=relaxed/simple;
	bh=Qyjkrg23NvqAtrZ6SXaT7ACN9JWfiY1iU+ZEiaE5bX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLbloQZtRy/Cum3YTIwi1jEd5AMgxt6+2Czsnli3OZpYZHzFyLoSG2j2AP198Hyq8y2STTREUqsIiOXcONP/yWTj/y13tH+8nrSERm9Zw/L16A00v+5avlxXEZpJS+cTOatlnn2LAC3wp8UNDlNPOPh1qR4zHVRUOX44mU8z1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=dTbDBlkA; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="dTbDBlkA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576664;
	bh=Qyjkrg23NvqAtrZ6SXaT7ACN9JWfiY1iU+ZEiaE5bX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTbDBlkAOP9Y0rUXJm+jhDhi4QywsUXy8ZAKZU4ZFWSsh40c9d1cVsdhUXCB2hWTD
	 uRkkenPEXyNbLZW8M96f6NF5ZPkoI1yP3Nnwzs4JkUHz4vExNC7io4dmatomg/rUEY
	 0pmZ9cz8Ubk+EzCV+wCJce2mm9lkRAGHE+r3EQ5qres5Y3C9eCpnLhP45fW5pOrJxJ
	 jlK4kEta6ULj/j4JpJXPVbsDyDmm+GPOiRsh58sVgONUk7tDsz9QghkvtFqtGDHE1e
	 lAITtTy2/yepcOORQfiV08n0wmr9/OAOWnwukgvJw17RZaUWNH6sjwcR7YvfosPzxt
	 0nL0cBNYWsnRA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 22/24] Revert "drm/i915: Depend on !PREEMPT_RT."
Date: Fri, 20 Feb 2026 09:37:20 +0100
Message-ID: <20260220083657.28815-48-dev@lankhorst.se>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Once the known issues are addressed, it should be safe to enable the
driver.

Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 5e939004b6463..40a9234e6e5dc 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -3,7 +3,6 @@ config DRM_I915
 	tristate "Intel 8xx/9xx/G3x/G4x/HD Graphics"
 	depends on DRM
 	depends on X86 && PCI
-	depends on !PREEMPT_RT
 	select INTEL_GTT if X86
 	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
-- 
2.51.0

