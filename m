Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A12FC029
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Nov 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164952; cv=none; b=Lyu6hzLkx2D64DaNaqkdC885N7awr0oeYYemVtxjB5kvxLYCzqfufXmYYQGafxVlQEvkrhhI8JeD9ltMNs5bk1Lwo9hCrpI+Bzjvs91l0V8RbE3D7FquRCIFNU09KoceuFvSll47UyKMoFi9Msh7anL8F6MJIBvGOuhRNgLSTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164952; c=relaxed/simple;
	bh=us5vuZz7G70dTjo7U50LuPzQuNUEkeodpdBWCo7yPUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMyxJilUrszS2lD2ZdzMxR2N5dAcP5SduC9BnC6xgMvqJJjHymOwkpAm/Mqh1egzjZWi9wJYZhHhKeivwpft7Vp8vzcC+mErhdS7a5xF4GnMHZGxUubMNmTNLiS7Vrq9QJJDePzHQ7rHlp3iKS9npDn6J6+FL5UGpTDfSBQ2B6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OQipPlZ/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ldr/weto; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OQipPlZ/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldr/weto"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762164949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZRlBrGWRm8/WFIoJDNgIH6m5X7XtAKEAZi/T3mFxxA=;
	b=OQipPlZ/OdaqOw2HJaVx7WO095xRZYAqzz4KEG28MK2PEODbohaG0EHxLsPD49VjULZVO0
	fd5E6WGRfbe8t3E1DI9rFAVB+fsKNLE9fc+oCxbDN+YK8P/WBwn7z2SIGUJn203+cpruYs
	QHqKH2STaAs0p9VvUQp9Nfq+KMDlZYQ6ynmEV2McXdR5fZe/NEo3+6+5rTKGuDPpI//PJv
	IrCMJf7Ze5pfeVujaJ/Tbzkk8G9gK9VUgbingTrqqx6S1gidMQ9T74wiGT8WdT9zp1OExn
	SiyboC5PE7nTJNfuRCHCMldsMAAFsC1PYsKfForC9zbLoG7QIfPkEZ06448Unw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762164949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZRlBrGWRm8/WFIoJDNgIH6m5X7XtAKEAZi/T3mFxxA=;
	b=ldr/wetoW3v+nVgu78ujUV8d6HYWMfbEggHbECCLT9Sxy6zbCDnY/DRfRzX1ejvkmzOyNi
	HWjYWU3+6aNb2WCQ==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 4/5] ARM: Disable HIGHPTE on PREEMPT_RT kernels
Date: Mon,  3 Nov 2025 11:15:44 +0100
Message-ID: <20251103101545.760243-5-bigeasy@linutronix.de>
In-Reply-To: <20251103101545.760243-1-bigeasy@linutronix.de>
References: <20251103101545.760243-1-bigeasy@linutronix.de>
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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92ca24336ec4b..45d29320196f0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1213,7 +1213,7 @@ config HIGHMEM
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

