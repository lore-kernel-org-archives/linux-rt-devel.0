Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4923DEBB;
	Tue, 10 Dec 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846806; cv=none; b=ImMCg5xhFpYr18ym4PfAlEarsfRvbOj/moBQsLA5P8zRq3fasfjvcHS4YA7ttAW0sEo2ifOmR01fJtyh5Os2EpatfeZOkzqt7FaRSbO2Swhv8aoB1YjvX1DJzing9/k3W14Yvi5kyDytB1rFo7l6GG+HY6n2AyGBdTGdHrBcVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846806; c=relaxed/simple;
	bh=wxcjY6Sxsaz2hTsZ9OLXJZ3XXXODa/UsYKOkty8coHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ck86OacM2JXWX+n8UqXls98lxyTRCO9uFZYgpcQW+CJ90vFtY8mS6HuH/LwcVIOr0r0mIx83y8tQ+oHzIxTuynFBmG6vVjXJ921RLryuTCjiim2yHIrrXtIq2Ub5hg40B+D+JzrIk7rHtIQOF/pPZEHeNSNaHgm9vxrQadVLO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1E8oc1U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1E8oc1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C9DC4CEE2;
	Tue, 10 Dec 2024 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733846806;
	bh=wxcjY6Sxsaz2hTsZ9OLXJZ3XXXODa/UsYKOkty8coHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1E8oc1U42hpuavRnkbvtANsKDn6k+Yz5tBBqHzq5EK5TUqUHa36DOjdsZtM9/Oah
	 7Ob9TQmtp+TOGUxnPtTmLmpIqpnNroAzwnwmKUX1z2y5QJwZPjTBumWMwxlbxrJQSL
	 XoGjjYk7/bX9yNbgOjxxo7jOVri9x8edVaTFuojVFYs2+5qimV28MQOYmCOpDoZ2hZ
	 3WTBquHU2z6SE3hFNLNM85NRZOHnW3qjqYiCxnAFISoWZu2F1V4EvZJlQ1m0lTFihC
	 7qBKTrXhoKxEhKdX/7Db81ANvpyxEUk+sFfpsf2DdNRV2wLjIJfc+yFATv/VLswlTx
	 xiIo205ZM9XMQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/4] ARM: Disable HIGHPTE on PREEMPT_RT kernels
Date: Tue, 10 Dec 2024 17:05:54 +0100
Message-Id: <20241210160556.2341497-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210160556.2341497-1-arnd@kernel.org>
References: <20241210160556.2341497-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
There is an open question about whether HIGHPTE is still needed
at all, given how rare 32-bit machines with more than 4GB
are on any architecture. If we instead decide to remove HIGHPTE
altogether, this patch is no longer needed.
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ed850cc0ed3c..4de4e5697bdf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1231,7 +1231,7 @@ config HIGHMEM
 
 config HIGHPTE
 	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
-	depends on HIGHMEM
+	depends on HIGHMEM && !PREEMPT_RT
 	default y
 	help
 	  The VM uses one page of physical memory for each page table.
-- 
2.39.5

