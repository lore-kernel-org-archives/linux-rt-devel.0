Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FE02BB1B;
	Sun, 17 Nov 2024 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731822045; cv=none; b=fS+maqHgI9tiNr1l6fPLnw1SC6GTxOjyQ7ZYBTw+j9I01ojUqW1hbb2yR2vOOI7y7eGHXDuomyxBW4K8/4uMtktxnqK0+tuWPf82zuv1DJJAcyREtqEvwO/usl2Qf1RUFT6aRKDR8cJqtrUMdCKfZfDL/2IgL82S1nUk7YowC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731822045; c=relaxed/simple;
	bh=HiwAANTSwAfFIKrWZkTO28KoW/2mSL+qH8HR4Z16QK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnVCJrm0SjJE8d4erUjhbqBqGtEozffICpXy78ssInosD3f8Bs5MEedja5BVYwxUhWnUlzFS34ucyTL4iXs+wW4cfOaGHDgxwFv2oaBa0+Dxw8dkjOVJnTpa/LhO1zky6OzVxKeBFl7vL6Cr+jyYrJmTYcENzZgsDSUQoTeoOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.202])
	by gateway (Coremail) with SMTP id _____8AxbeLXgTlnIAxAAA--.60383S3;
	Sun, 17 Nov 2024 13:40:39 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.202])
	by front1 (Coremail) with SMTP id qMiowMBxO+DDgTlnJ4NZAA--.10317S3;
	Sun, 17 Nov 2024 13:40:39 +0800 (CST)
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
Subject: [PATCH V2 2/4] LoongArch: Fix sleeping in atomic context for PREEMPT_RT
Date: Sun, 17 Nov 2024 13:40:15 +0800
Message-ID: <20241117054017.3938700-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241117054017.3938700-1-chenhuacai@loongson.cn>
References: <20241117053740.3938646-1-chenhuacai@loongson.cn>
 <20241117054017.3938700-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxO+DDgTlnJ4NZAA--.10317S3
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCry3GFyfKF13CrWrKFyxtFc_yoWrAr18pr
	yUtr18Cr4kXr1UAr47AF1UZr4DZrs5CF48Jr4xJr1UXr1jgr1UJr1kJr15tryUJrWUJFZ8
	JF1DJF1rtw1UJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU00eHDUUUUU==

Commit bab1c299f3945ffe79 ("LoongArch: Fix sleeping in atomic context in
setup_tlb_handler()") changes the gfp flag from GFP_KERNEL to GFP_ATOMIC
for alloc_pages_node(). However, for PREEMPT_RT kernels we can still get
a "sleeping in atomic context" error:

[    0.372259] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[    0.372266] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
[    0.372268] preempt_count: 1, expected: 0
[    0.372270] RCU nest depth: 1, expected: 1
[    0.372272] 3 locks held by swapper/1/0:
[    0.372274]  #0: 900000000c9f5e60 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x524/0x1c60
[    0.372294]  #1: 90000000087013b8 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x50/0x140
[    0.372305]  #2: 900000047fffd388 (&zone->lock){+.+.}-{3:3}, at: __rmqueue_pcplist+0x30c/0xea0
[    0.372314] irq event stamp: 0
[    0.372316] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.372322] hardirqs last disabled at (0): [<9000000005947320>] copy_process+0x9c0/0x26e0
[    0.372329] softirqs last  enabled at (0): [<9000000005947320>] copy_process+0x9c0/0x26e0
[    0.372335] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.372341] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.12.0-rc7+ #1891
[    0.372346] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/21/2022
[    0.372349] Stack : 0000000000000089 9000000005a0db9c 90000000071519c8 9000000100388000
[    0.372486]         900000010038b890 0000000000000000 900000010038b898 9000000007e53788
[    0.372492]         900000000815bcc8 900000000815bcc0 900000010038b700 0000000000000001
[    0.372498]         0000000000000001 4b031894b9d6b725 00000000055ec000 9000000100338fc0
[    0.372503]         00000000000000c4 0000000000000001 000000000000002d 0000000000000003
[    0.372509]         0000000000000030 0000000000000003 00000000055ec000 0000000000000003
[    0.372515]         900000000806d000 9000000007e53788 00000000000000b0 0000000000000004
[    0.372521]         0000000000000000 0000000000000000 900000000c9f5f10 0000000000000000
[    0.372526]         90000000076f12d8 9000000007e53788 9000000005924778 0000000000000000
[    0.372532]         00000000000000b0 0000000000000004 0000000000000000 0000000000070000
[    0.372537]         ...
[    0.372540] Call Trace:
[    0.372542] [<9000000005924778>] show_stack+0x38/0x180
[    0.372548] [<90000000071519c4>] dump_stack_lvl+0x94/0xe4
[    0.372555] [<900000000599b880>] __might_resched+0x1a0/0x260
[    0.372561] [<90000000071675cc>] rt_spin_lock+0x4c/0x140
[    0.372565] [<9000000005cbb768>] __rmqueue_pcplist+0x308/0xea0
[    0.372570] [<9000000005cbed84>] get_page_from_freelist+0x564/0x1c60
[    0.372575] [<9000000005cc0d98>] __alloc_pages_noprof+0x218/0x1820
[    0.372580] [<900000000593b36c>] tlb_init+0x1ac/0x298
[    0.372585] [<9000000005924b74>] per_cpu_trap_init+0x114/0x140
[    0.372589] [<9000000005921964>] cpu_probe+0x4e4/0xa60
[    0.372592] [<9000000005934874>] start_secondary+0x34/0xc0
[    0.372599] [<900000000715615c>] smpboot_entry+0x64/0x6c

This is because in PREEMPT_RT kernels normal spinlocks are replaced by
rt spinlocks and rt_spin_lock() will cause sleeping. Fix it by disabling
NUMA optimization completely for PREEMPT_RT kernels.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 5ac9beb5f093..3b427b319db2 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -289,7 +289,7 @@ static void setup_tlb_handler(int cpu)
 		/* Avoid lockdep warning */
 		rcutree_report_cpu_starting(cpu);
 
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
 		vec_sz = sizeof(exception_handlers);
 
 		if (pcpu_handlers[cpu])
-- 
2.43.5

