Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747271F1932;
	Sun,  1 Mar 2026 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328464; cv=none; b=X0865qN7f+eFBWCYql8b0spp16HiCwz9tdqxImIfhK+mXXRomPReJpzLF1UVk0P/hd822gCz3v5ur3cmgtleZ3lTfq/5sgBpHZ0P1vxSTJsmI1ObsEUsIfm44IMYFqdeD16JSshONJN5tMieo+rpVvGRcpUtr/cDyL9Su2uvm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328464; c=relaxed/simple;
	bh=mRh3b3pZjH+YVpNFWsrbOgxIKSfnNg8TZg6RG8HEdlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jaC4cEboPuGssxWs6QwRTOglm4eT3oXF101XhP64uOPN09AW/8DCZFPN6rrGf23z7myXGVmlaYKjjIBUs8zUgWZ8Hw/9vgAF+J3I6fN3YhfHJgXN7IXhzGNQvvqvTr5jDHdTkFavdMoMHLDC/HzbVq6+M0MDuPh9gbXSyAhMrNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SevvrnkT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SevvrnkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB83C19421;
	Sun,  1 Mar 2026 01:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328464;
	bh=mRh3b3pZjH+YVpNFWsrbOgxIKSfnNg8TZg6RG8HEdlE=;
	h=From:To:Cc:Subject:Date:From;
	b=SevvrnkTaLPqGBfLKPe7RStUth86/eRUPCS5fhR8VyelJdoYjzMEiWyXkx24+LJnR
	 gcMFLu3zJu8QErOFZVgwnHyZhsGfBspWS/gLYuc+OobUsKGuSe6LiX2aMuT+enHQ6w
	 Y1yT/x7mBD9/1H5Kl9/wWRZ57SV7j12nqP65b2MJz+sWZLoJYW4VydkSBgLjGJQvVf
	 aUti8PbC2M1RHtTIHfpssUON/RoKapmCBpJChiInMPqRW6FxvoUnO43ZVp/myLh9VE
	 PnKCf7xuATyQipZe0npHpJv39+un4g8wmI2jVpWJ4g3k4LzznX9LGwfJfV5PRIVxrp
	 6G74m5yTg3/Gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-rt-devel@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Guard percpu handler under !CONFIG_PREEMPT_RT" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:27:42 -0500
Message-ID: <20260301012742.1685273-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 70b0faae3590c628a98a627a10e5d211310169d4 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue, 10 Feb 2026 19:31:13 +0800
Subject: [PATCH] LoongArch: Guard percpu handler under !CONFIG_PREEMPT_RT

After commit 88fd2b70120d ("LoongArch: Fix sleeping in atomic context for
PREEMPT_RT"), it should guard percpu handler under !CONFIG_PREEMPT_RT to
avoid redundant operations.

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/unwind_prologue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index 729e775bd40dd..ee1c29686ab05 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -65,7 +65,7 @@ static inline bool scan_handlers(unsigned long entry_offset)
 
 static inline bool fix_exception(unsigned long pc)
 {
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-- 
2.51.0




