Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891D302774
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Nov 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786584; cv=none; b=cbtITAWr44iqtjJuQplUQOWSVLxThJpJhz0nj3X9PmZ0O0sWUuDjMU4LJq8BdhlCLNmiWLbWa0zme3ftNam/z5EiaHu72p8w8IZLDJC8HrOAO2B2RQ/gU2sI4qP5YRbL3a30N8Wm7xnn0EhcpxOc+V0wDZzKjtyUmrwkopIlJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786584; c=relaxed/simple;
	bh=TCDeKAqSgeWEShhKZ42PlhGu31Qi5eSA4JkFTgVv6Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaGByLKYqde6CbJzg5Gxm0ZuyjL0pWVu6OuKMxUe9cugH4J7O+MEyouGaJygFYf6c1yjNydfviZpk5okvlGWztto17QdW2h2w7gUwPBXMpu6wYzAwuKUG2yUQLeG0LYGhZPgB9+xHxfdHyaYDdmmh0sSKMua2+pGbGxGl+ZQxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z6RXScNg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lmKEleJ9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z6RXScNg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lmKEleJ9"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762786581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGEd2ctvwFIV9lZCkqIgoelHcMqfqI31DvTGYMHpmGU=;
	b=Z6RXScNgKW7qDh/q7fA53B9NytUe3pY3M7uWoTHpC/cl9yMpyTBr0x8SRnNwRoEvcXtr1X
	RS1wLsk9JtQjXDwdK2O3TfyPXFv8jUUuTmvyML17O8GAe3SvKInkCoDxcjCq/HSYvVGXOh
	hm8OOkaY7zTn1Z57zJv/sL/Q2ftDPFbxCXqzamXRNDhXgARh77sqE3dWYwbeMBPkuJYN6d
	G8sBTxmtYD5nvrUSbaInmwrYls8qM37aLd0mvf1jzjjO/rwdoRB7VRhd1Oqwp8m8PSle6x
	dqkjrSXCSMIdKB69+fE381QlCD+55FjmiVkyamYvUvHfTSrbAOAXyKWrhLnqpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762786581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGEd2ctvwFIV9lZCkqIgoelHcMqfqI31DvTGYMHpmGU=;
	b=lmKEleJ94p+r6QN17FFVuwB7rcYnd8vM2XNPvFelfsuBp2BvoOx2z86kvGOZWoRMj1ShhE
	fcXMd6jXYS3HIPCQ==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 4/5] ARM: Disable HIGHPTE on PREEMPT_RT kernels
Date: Mon, 10 Nov 2025 15:55:54 +0100
Message-ID: <20251110145555.2555055-5-bigeasy@linutronix.de>
In-Reply-To: <20251110145555.2555055-1-bigeasy@linutronix.de>
References: <20251110145555.2555055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

gup_pgd_range() is invoked with disabled interrupts and invokes
__kmap_local_page_prot() via pte_offset_map(), gup_p4d_range().
With HIGHPTE enabled, __kmap_local_page_prot() invokes kmap_high_get()
which uses a spinlock_t via lock_kmap_any(). This leads to an
sleeping-while-atomic error on PREEMPT_RT because spinlock_t becomes a
sleeping lock and must not be acquired in atomic context.

The loop in map_new_virtual() uses wait_queue_head_t for wake up which
also is using a spinlock_t.

Since HIGHPTE is rarely needed at all, turn it off for PREEMPT_RT
to allow the use of get_user_pages_fast().

[arnd: rework patch to turn off HIGHPTE instead of HAVE_PAST_GUP]

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5941566df3ed0..822d378f81ec8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1215,7 +1215,7 @@ config HIGHMEM
=20
 config HIGHPTE
 	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
-	depends on HIGHMEM
+	depends on HIGHMEM && !PREEMPT_RT
 	default y
 	help
 	  The VM uses one page of physical memory for each page table.
--=20
2.51.0

