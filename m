Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0772857CD
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576671; cv=none; b=iH4nR3byKYlb4Nyq+ao8SQEyWKrB6FTArjSYTCk4RO8pX3JHqfr/0pml637/lk7/FxEfdkC9U1aKNVKMafRNalKpJXWeyZOC27bfbP7FmSV90p3Tpea5XYQeFKMg0XdybblLtuJAsqiBPwWEvGEyzFxjtZKXCAim8ceKaHiFr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576671; c=relaxed/simple;
	bh=hfuiKbZoiFCdq6MXoxyC1QnOf4JbUHSRhvGeWVtO/UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mfi7Aqqt2FpqFkxWQrpvEvjDhv8UWyr0aBLlC7k4XpCdSiXf27bhQYIsoSrreqHtBONNQHxiMPytCf4kt+uLwh943op0hvvuEaKZ29xqZyYxAFxrpB+zez+YmdE0zAPlwzQHaSdKpjX48upsOXKOsQeEeYHEy9QKcpvgf6VE5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=Ygd+mLi5; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="Ygd+mLi5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576668;
	bh=hfuiKbZoiFCdq6MXoxyC1QnOf4JbUHSRhvGeWVtO/UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ygd+mLi51GLCi0eC2c+EoXxZSORJlds+tSDj0V3QLkVeEorJD2DUr2uJ4vJyndfDZ
	 xep0YcFkzuAhp7cUUySMvTVXuVxnh2bh74hk0ueugoiu4ug24k3Qc7MY9XLY63+gdF
	 iZ30CE/yFnkymmASNTSone1g4Na2BOsMguWOEOtahqG1eC3XJKdLNhcXse/gqehfhW
	 uvLvtJs6JO69SVC4JihMMsETmsf4Fb2XJrQ5iYh6PxUwlrEIlv/jtdFiuStA6RTCdt
	 a5FmXZbt/iHKNg2bdcGbtg4weJLRGo3935qAt3+pbNdnnDLaq4mCI8ODGvo18Dtgrp
	 VHDxdPWl068qQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 24/24] FOR-CI: bump MAX_STACK_TRACE_ENTRIES
Date: Fri, 20 Feb 2026 09:37:22 +0100
Message-ID: <20260220083657.28815-50-dev@lankhorst.se>
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

We're hitting a bug in CI where MAX_STACK_TRACE_ENTRIES is set too low.
My guess is the repeated loading/unloading is creating multiples of the
same entries. As a hack just reset lockdep. This might only be necessary
for CI + PREEMPT_RT.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1e1776049a84e..e8da58d2bf5c8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1545,8 +1545,8 @@ config LOCKDEP_CHAINS_BITS
 config LOCKDEP_STACK_TRACE_BITS
 	int "Size for MAX_STACK_TRACE_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 26
-	default 19
+	range 22 26
+	default 22
 	help
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
 
-- 
2.51.0

