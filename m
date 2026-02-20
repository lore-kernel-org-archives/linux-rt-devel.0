Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132AE27B352
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576664; cv=none; b=XUwlOA3xkesYW0jy4h5n6rhnrE2iulFTXGR7jXD9vYqXJq4UhkgIBx5Yuv9D7DinxkjzoTY47AXTWKc8TYzRn9ax97PxSAwUgdnn+LWKoPwEjHfaJOCmyQLVc16V1ByTooPs6/8g46PFvB4VJRuPAKLI22GmnFDt22kYsSf9+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576664; c=relaxed/simple;
	bh=JuDaK8knmnwvqTPCaZ8kVF3zfXGpF13hHheMLbZ3m3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rj3uEBW2Uz/odoskx7iTHbx3t35UmawkzD93Cva9PhBLa0WLR2qmf6cQ39X7v9mOyv+mD8/m2A7XEleuowGuEB9qUwJQN/ZqRB8MGG59AZjQsOj+DlsdVW8dbJf02KFfKGENrtDSL3/q1Jg3p0JQ1L7SL7O94pijp/SWOg76tIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=QAFTAp14; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="QAFTAp14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576661;
	bh=JuDaK8knmnwvqTPCaZ8kVF3zfXGpF13hHheMLbZ3m3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QAFTAp141cCiQq2ehDDELuLHAFEKUc0rZWB81EhIxVBOVGZlpFsXLXbxCHyK+5phB
	 PaM2oD/VbnzgF8kLlPPFOuqreKmPnmUuXEbYU7Sr1HeYxMMjo1aKvqVWrsigC7guKv
	 Q0vAZPd8PsaMHEN8HYq2h36TfaaG4A3Z7JmyAFDReJIeS8en46oE/bLa/vnIzwSEQj
	 8V7KH2+VONwWXuuNKoOa++bXz4kJrWAxRLUk5z5YSEeuQyJROFRVkxxb0MG/+l6LSV
	 TVoj8R9I/JrT0eXu2MluCffSg2WN/ULN1xDobHnnQstONjWvSVUiRd+GoG6c3E35sM
	 BebajrwHcjTFg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 20/24] drm/i915/gt: Set stop_timeout() correctly on PREEMPT-RT
Date: Fri, 20 Feb 2026 09:37:18 +0100
Message-ID: <20260220083657.28815-46-dev@lankhorst.se>
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

Also check if RCU is disabled for PREEMPT-RT, which is the case when
local_bh_disable() is called.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index 98a3a7a9de502..856250b457a55 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -1607,7 +1607,7 @@ u64 intel_engine_get_last_batch_head(const struct intel_engine_cs *engine)
 
 static unsigned long stop_timeout(const struct intel_engine_cs *engine)
 {
-	if (in_atomic() || irqs_disabled()) /* inside atomic preempt-reset? */
+	if (in_atomic() || irqs_disabled() || rcu_preempt_depth()) /* inside atomic preempt-reset? */
 		return 0;
 
 	/*
-- 
2.51.0

