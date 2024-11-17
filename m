Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3E214A85;
	Sun, 17 Nov 2024 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731821883; cv=none; b=Kr+0U5E0lnny47VslF9wot+19N/kL/XBnThNZEV8Pool9V7V+/NIby6vVPgn71Mzv1TqbalvA5kirrXToO6D+BSHJva5iPKBYE8+tyzObX3utOe/LBRj9ihlBXQGgEULjzU9fu/mxRpS7WkA7R20VLRQ6EjhU+8VINfC7Nqz4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731821883; c=relaxed/simple;
	bh=EeVrEIUZXLaSoNuWD/hKzgiAhS1Gq82yDFfoKF77bmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5fMDUDYckOE4mhtL7Tyh2qa+vUQECVmUN7dYiSP4zv7ZvKBFSlrLwUpSlA3YKF209lzHKlOUafDOYCgve2LM4KNEl21SNATptvsydaQiTM3evLO8aPcJDaFunHsWVCuuKRv1VuT/a4fPPhTs6HxIpfTYPnBGJBQY95+Y22zjxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.202])
	by gateway (Coremail) with SMTP id _____8DxDeM1gTlnwQtAAA--.59647S3;
	Sun, 17 Nov 2024 13:37:57 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.202])
	by front1 (Coremail) with SMTP id qMiowMBx68EwgTlnnIJZAA--.6029S2;
	Sun, 17 Nov 2024 13:37:56 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: loongarch@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 0/4] LoongArch: Add PREEMPT_RT support
Date: Sun, 17 Nov 2024 13:37:36 +0800
Message-ID: <20241117053740.3938646-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx68EwgTlnnIJZAA--.6029S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtr1kCFWDAw18Zr4rXrWDtrc_yoWfuFc_Ga
	yfGw1Uur18G3y7Zwn3tw1rJ3srCa10gr43u3s7XF43XryFkrs5trs5GF48Arn0gFW7Xrsx
	JayDAr15ur9IvosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbVAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jepB-UUUUU=

This series add PREEMPT_RT support for LoongArch.

With the recent printk changes, the last known road block has been
addressed. The main architectural preparation we need is selecting
HAVE_POSIX_CPU_TIMERS_TASK_WORK to allow PREEMPT_RT coexist with KVM.
Then we can also enable PREEMPT_RT as X86, ARM64 and RISC-V.

V1 -> V2:
1. Fix sleeping in atomic context for PREEMPT_RT.
2. Reduce min_delta to 100 for PREEMPT_RT and update commit messages.

Huacai Chen(4):
 LoongArch: Reduce min_delta for the arch clockevent device.
 LoongArch: Fix sleeping in atomic context for PREEMPT_RT.
 LoongArch: Select HAVE_POSIX_CPU_TIMERS_TASK_WORK.
 LoongArch: Allow to enable PREEMPT_RT.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig       | 2 ++
 arch/loongarch/kernel/time.c | 6 +++++-
 arch/loongarch/mm/tlb.c      | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)
---
2.27.0

