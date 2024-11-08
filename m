Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70371E049C;
	Fri,  8 Nov 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057443; cv=none; b=fEKk3breNxR6rw6fxV1As5oBRkrdEF+IGFYIVGTgDKeiz387poJZbgPPQr3kg/KBHC+4SfhABpmd1GXPUZzMQd7SxbvpJB8/r7uDlrnh+RIk7N5bRv62+9o8HzRrezj+Ku91U8cohTQvJ4VwnXhCAXf7hsWco8Sn1fNNhv3zkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057443; c=relaxed/simple;
	bh=Bbcx8onFO1llkh1bzdef+8Wwk79wyxRsWbhQhNlkkZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzK0jGL1Cp4NNxlplAtHedUUKiXFF0iQ8hJBavX5OR6ulU1Rbh40Kg1TsdAapBppJntir7SKSH0wGU3t2iUwSOEZPL7rVZDgH4TP69YNwxKw04xtxxKiJtjJJPsgQoo8+l+zpa4HHOrS1kTVjvWn6ztSkXiRvnQupkSJwiaen4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB498C4CECD;
	Fri,  8 Nov 2024 09:17:20 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 2/3] LoongArch: Select HAVE_POSIX_CPU_TIMERS_TASK_WORK
Date: Fri,  8 Nov 2024 17:15:44 +0800
Message-ID: <20241108091545.4182229-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108091545.4182229-1-chenhuacai@loongson.cn>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move POSIX CPU timer expiry and signal delivery into task context to
allow PREEMPT_RT setups to coexist with KVM.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index bb35c34f86d2..3734f5dd9a57 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -155,6 +155,7 @@ config LOONGARCH
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE if UNWINDER_ORC
-- 
2.43.5

