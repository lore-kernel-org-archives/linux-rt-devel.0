Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F22FE07D;
	Sun,  1 Mar 2026 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330116; cv=none; b=a2ejrXcooTSx5hJ1xKBeDsGZxhELSWQ+QrrAbRjmwhHsV4f9ko/MiiUU+9vMP5j8gD9QGDcNuMHowAjDHvQ/SpbgM5I2167XVPcvpaipv6L4ZxZOPb7NR1b5yGW3Axi/ktWOEHE/fvSrhd3H1XcsgVqD5hT167/wrBsjesqkB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330116; c=relaxed/simple;
	bh=bhfHUyEcFd2BY07SAHZSvIUgr1GdW/hebPkTiFlnHvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q24VCCJ02LuxUAZ7xNuhOFk8tPrJkZBCm26ULd6W7glhTYz8JasDo+iGlqK2POsZWJaZwze7wH6aMZ9tv9n1v8ftgHRJGJVZWRrB3Uym/lDdATi7YjFUEaivZeqiXPUE7d0LqcbrxmEFLQZ/8eF6uFtEpv0H/3/CAm82JOh9aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw81YRVx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw81YRVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559FBC19421;
	Sun,  1 Mar 2026 01:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330115;
	bh=bhfHUyEcFd2BY07SAHZSvIUgr1GdW/hebPkTiFlnHvA=;
	h=From:To:Cc:Subject:Date:From;
	b=Gw81YRVxC9ymZ0K0UMYXJTgXbUBq1CzkL/2ngV36vxcasb+cEymnvzVvq5xRhm+7h
	 cDFatiQ8AZ1aVZjRuy+k5wDQ0zGQlZzx0wNhRqb35Yp8WWBEoqwNE0yc7hlaLHqv7i
	 7zae8yf4GIU5nx/zR7fHwvBKrNK9aHrvqV0jmkUq0+HfUwHG+LMu7WVbiPvPA1EtZy
	 H5zfneCulB09cFt8U6aWmZdpVilaE9dtWxh4Np/+UsmGdyh6msGIffagVN4kSAbn9B
	 4IzPlc0dNgPbvyENvhjp4T6ViM1JuDqhyeePL92+xHEU9uKeNYr/BIt1A8ks7y7Emr
	 WpKLPWYUezAiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-rt-devel@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Guard percpu handler under !CONFIG_PREEMPT_RT" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:13 -0500
Message-ID: <20260301015514.1722401-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
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




