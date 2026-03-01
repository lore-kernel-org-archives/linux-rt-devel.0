Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10576430B90;
	Sun,  1 Mar 2026 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329088; cv=none; b=n17sIEIlq4tfVg/g5UO703Wqt6Omt8Idtjgjtqk1P5ddXNeQBbCS5PomMSYg9CR/0b+WaF03S9VbXXlKgrjw7UxAGSJonGRtT/kKq0/6r1PLXwzvjzCGyY33UvQ3t2ONDESDoZVy7z9vaQhzWh7YOgyfl8nGg3r7V1no4m/OkQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329088; c=relaxed/simple;
	bh=7MlYN4RLXrfmHCPHrNSixL/jLatvU6Nx0EVa18paV18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POVXTXMNEdS+xQyyQMU91kcY4u5JIWf2tgkJ2VFDmIlN1zIbl9IiePTfPgZjb1tFOLcOIhKkm1YHFoLOwt8bxUPbLvGV50KNNHujCYLGGiWAqoOeCS88nTeR++KTUI7mpLFOQq4pecB5ikp1LDZT5ES4+Gto+XUR6DXu690rcZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAFWD4Az; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAFWD4Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A9CC19421;
	Sun,  1 Mar 2026 01:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329087;
	bh=7MlYN4RLXrfmHCPHrNSixL/jLatvU6Nx0EVa18paV18=;
	h=From:To:Cc:Subject:Date:From;
	b=CAFWD4AzDanXDpsus/hJAsAw5ngObUESxi+UR6fl+p57ujmLLzCyAYb38FiXoBHtO
	 zwezDoixD7WsfRO867QkzUifTUDVz0KmdRD1eT52Z95tnsJFvlWmY+MU7QmykVzfoV
	 VlAtdmtb2evyU+ssheP1IN76FTK7p0eUxPOoEIfdUgvf2NTUxCilKqUutppZQPbPOE
	 s6PEbfh1FTzWY4MrmD8pD//xDvqbudkzQ56whqtsV4jIZP4JFbhKQsxa7s3U8NWoBq
	 CpqVnTs0mmkmowP+HPxGD1s+eNK5d5F/p9GUYPCj4lSMp/vi/nUShl27bLZhGyDOFI
	 wOUIWMCHV/nOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-rt-devel@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Guard percpu handler under !CONFIG_PREEMPT_RT" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:05 -0500
Message-ID: <20260301013806.1698436-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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




