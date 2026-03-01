Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4DF190664;
	Sun,  1 Mar 2026 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330689; cv=none; b=ap5z6WNlLso0alaceE3ImhoTp/zS5UBupw8cblHeG1oxFhVYjI6Ha8vfolvm5Q3RFMRXCK0TRt50jYgJUL+TwmWd0TuZu+x7kiyx5eCYzSYbi0b97dejM7p7RWnKFx95Dn+8LLb2mV/cZThnQzjapED+8y8z7Npf/4VPtX1F0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330689; c=relaxed/simple;
	bh=aPqVASWYPjTFxvphLPhm3C+MRr5aUxO/V2l2UEtf0Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8h7BepuHp/fPgO1FbLRdmbOpuRMGKswU+WdMZgcdXZTC+HTcvd4qePG1pDgLJMobitXqWolhLpJsRwK59Z+uKtrMVgwqJJyWShmhZhD5DG8y3um6q8wr8b/EVFM+0smd9Mph8jgMuHJAVPt8DsDzxHYiu4CIQ8xVKOgFr9FWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piz7ZBc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piz7ZBc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC1FC19421;
	Sun,  1 Mar 2026 02:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330689;
	bh=aPqVASWYPjTFxvphLPhm3C+MRr5aUxO/V2l2UEtf0Sw=;
	h=From:To:Cc:Subject:Date:From;
	b=piz7ZBc6UB8Ng6di6qjM5zJqAwxt9di2Q6IzyF4vQkXF5P7Z9/UHU8zau0o2xUB0+
	 uJsREcjIh8iW4Ps8hX8q0z2u86Pa/PZdGO7V8jrUmxGUJiDJ1lPI6jFEuV6uPyFPnv
	 mz+ZSBn5Uf1OWeul6fSZxfZcyB+gUgg5NxwHWCQGtm7KlPJxcr9GVTtilh+G+p1rt5
	 4cmaUMj4q6IUMqGh8PAb30dEhXHg03FZDw2yM+b0M4tHZqGMZbmXaxPTM9A65nmMiV
	 mS9cADtsBGtZW76PaDlzK5fXw5yM7DO0eEv7rlBg3lNo6v2k9d64Q3QhlvFalttf12
	 Jfp9JV8lcksdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-rt-devel@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Guard percpu handler under !CONFIG_PREEMPT_RT" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:04:47 -0500
Message-ID: <20260301020447.1733307-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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




