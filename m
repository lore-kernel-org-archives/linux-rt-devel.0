Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF223DEBB;
	Tue, 10 Dec 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846799; cv=none; b=lQdjBTgAc1Emc6yl7ZIkYH5FJHEcai55culflI5rjofkbxJpEpmSkZoAaa/ABw9ZozbDol+Rw2ZjjfXkvsRIZUupTgMm1ZSfP1SyhbvI0rjLmZy+Y2mNbTbsxOXXBq5uRnFZ6dgS5MWBIiG++IZFhWD6zpDwzxgodOIn/vW3JEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846799; c=relaxed/simple;
	bh=/EJLCV9Nbr8z/O96b+uztb1OOD40c2eM9YQphH3+pAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RwN3ILYT01M8D5pG6LsHKeZvkAJGNbVSuNDLqMIBHezCxXWmko0XHOOXJJL0xdpPw/yrbEL8b5vXBj9OUWIlHKtESOIoE2/wIg46jWMB8OzDJWry94m+dXqykVIopunV5zVfhXasVJx3cy8rX8BbjaKKmc917YM1I+8RsNaKhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRU3ftX+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRU3ftX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34108C4CEEA;
	Tue, 10 Dec 2024 16:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733846798;
	bh=/EJLCV9Nbr8z/O96b+uztb1OOD40c2eM9YQphH3+pAU=;
	h=From:To:Cc:Subject:Date:From;
	b=rRU3ftX+twlXWaN+79xv665kO8GTDnwM12ZBEdFR6MfSY6RLbhue+timW9PEJLzVH
	 beh+aeK1Pi58eY9T5GdG9lKtRCsf8OCIgBxKZ/z8u+iHn6wOjoUvVsSj1wTiX2P8AK
	 Gg94zwt7HgC0V48enoGeycNlp0PCke484gZQy4qy9aufpc/byk2ZXYv3lpNFUnGj/q
	 ak+wSlWuHE9MCMOJLnrHzuSUEQ3l7NFw2vXA2zmMOggcrNHirXuiVKVKuzvhna/wH/
	 VMx4h09I3WzjCYDp+3jyz1J7H4FNGENzbpjMxf6CtTPspUPDtg858zwaCd7tYj/fdB
	 Awv+i++19po7g==
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
Subject: [PATCH 0/4] ARM: towards 32-bit preempt-rt support
Date: Tue, 10 Dec 2024 17:05:52 +0100
Message-Id: <20241210160556.2341497-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Linux-6.13 contains a few patches required as preparation for
CONFIG_PREEMPT_RT, there are three more left, out of which I have reworked
two slightly:

 - The jump-label patch from Thomas get a little more background
   information, and an improvement for non-SMP kernels

 - The HIGHPTE patch from Sebastian now has the reverse dependency,
   turning HIGHPTE off instead of PREEMPT_RT.

As Matthew Wilcox noted, we can probably remove HIGHPTE support entirely,
so I include two more patches for review here that do just that, with
linux-mm added to Cc.

The final RT patch for the entry path is not included here as I'm waiting
on some work from Linus Walleij. Hopefully it will no longer be needed
after then next version of his generic entry series, see
https://lore.kernel.org/lkml/20241029-arm-generic-entry-v2-0-573519abef38@linaro.org/

      Arnd

Arnd Bergmann (2):
  ARM: drop CONFIG_HIGHPTE support
  mm: drop HIGHPTE support altogether

Sebastian Andrzej Siewior (1):
  ARM: Disable HIGHPTE on PREEMPT_RT kernels

Thomas Gleixner (1):
  ARM: Disable jump-label on PREEMPT_RT

 arch/arm/Kconfig               | 13 +------------
 arch/arm/include/asm/pgalloc.h |  8 +-------
 include/linux/hugetlb.h        |  5 +----
 include/linux/mm.h             |  1 -
 include/linux/pgtable.h        |  9 ---------
 5 files changed, 3 insertions(+), 33 deletions(-)

-- 
2.39.5

Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rt-devel@lists.linux.dev
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Clark Williams <clrkwllms@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
