Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BA02940B;
	Sun, 17 Nov 2024 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731822051; cv=none; b=n5TklgYeGR73cowMf7WewJBT00fdw4DV3d2Jx44bOnntJMeOv5foRg4xtOfKTS0z4J0aGhulqlS7Mt7Z7w0F0rKzpt6pnuNTYV5OCKkAx3d+K/XI+LWJAcAdQJQWciwqvbegTMfvtq7nffVwDx0IdbD2MjaLxuZggFLMQeyxF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731822051; c=relaxed/simple;
	bh=7iP/fa1aai2hMEMXRhOdiCduyARbmA0G/XoyLsZYC0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfbAiUWJxO65QyNLLoXn4FqVHY450ZhBO1699imY/cJuycmL8y1xOO/tOmm7m7xpHmGyvbJhPSn6oaYN65stA4cW84x4Uu4g+CEO3U4vXvOB1IHuFyY4/p6zEqU8KFiESYywQnHe/cUScwY0ZiQ80NuZPcWx5dGbG/tppw0nMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.202])
	by gateway (Coremail) with SMTP id _____8CxyuDfgTlnMwxAAA--.59628S3;
	Sun, 17 Nov 2024 13:40:47 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.202])
	by front1 (Coremail) with SMTP id qMiowMBxO+DDgTlnJ4NZAA--.10317S5;
	Sun, 17 Nov 2024 13:40:47 +0800 (CST)
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
Subject: [PATCH V2 4/4] LoongArch: Allow to enable PREEMPT_RT
Date: Sun, 17 Nov 2024 13:40:17 +0800
Message-ID: <20241117054017.3938700-4-chenhuacai@loongson.cn>
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
X-CM-TRANSID:qMiowMBxO+DDgTlnJ4NZAA--.10317S5
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF43tw18XrWUAF43uryUArc_yoW5JFWxpr
	Z7AF4kAFWxuwn5JFsag348C3yUu3Z7Gay7XFyDA348CFyq9a4SgryrCr129F1Uuan2q34D
	XF9xKFy8XF98CFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0_WrPUUUUU==

It is really time.

LoongArch has all the required architecture related changes, that have
been identified over time, in order to enable PREEMPT_RT. With the recent
printk changes, the last known road block has been addressed.

Allow to enable PREEMPT_RT on LoongArch.

Below are the latency data from cyclictest on a 4-core Loongson-3A5000
machine, with a "make -j8" kernel building workload in the background.

1. PREEMPT kernel with default configuration:

./cyclictest -a -t -m -i200 -d0 -p99
policy: fifo: loadavg: 8.78 8.96 8.64 10/296 64800
T: 0 ( 4592) P:99 I:200 C:14838617 Min:   3 Act:    6 Avg:    8 Max:    844
T: 1 ( 4593) P:99 I:200 C:14838765 Min:   3 Act:    9 Avg:    8 Max:    909
T: 2 ( 4594) P:99 I:200 C:14838510 Min:   3 Act:    7 Avg:    8 Max:    832
T: 3 ( 4595) P:99 I:200 C:14838631 Min:   3 Act:    8 Avg:    8 Max:    931

2. PREEMPT_RT kernel with default configuration:

./cyclictest -a -t -m -i200 -d0 -p99
policy: fifo: loadavg: 10.38 10.47 10.35 9/336 77788
T: 0 ( 3941) P:99 I:200 C:19439626 Min:   3 Act:   12 Avg:    8 Max:    227
T: 1 ( 3942) P:99 I:200 C:19439624 Min:   2 Act:   11 Avg:    8 Max:    184
T: 2 ( 3943) P:99 I:200 C:19439623 Min:   3 Act:    4 Avg:    7 Max:    223
T: 3 ( 3944) P:99 I:200 C:19439623 Min:   2 Act:   10 Avg:    7 Max:    226

3. PREEMPT_RT kernel with tuned configuration:

./cyclictest -a -t -m -i200 -d0 -p99
policy: fifo: loadavg: 10.52 10.66 10.62 12/334 109397
T: 0 ( 4765) P:99 I:200 C:29335186 Min:   3 Act:    6 Avg:    8 Max:     62
T: 1 ( 4766) P:99 I:200 C:29335185 Min:   3 Act:   10 Avg:    8 Max:     52
T: 2 ( 4767) P:99 I:200 C:29335184 Min:   3 Act:    8 Avg:    8 Max:     64
T: 3 ( 4768) P:99 I:200 C:29335183 Min:   3 Act:   12 Avg:    8 Max:     53

Main instruments of tuned configuration include: Disable the boot rom
space in BIOS, in order to avoid kernel's speculative access to low-
speed memory (i.e. boot rom space); Disable CPUFreq scaling; Disable
RTC synchronization in the ntpd/chronyd service (also avoid other RTC
accesses when running low-latency workloads).

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2443d5a80e0d..d5d3679057a1 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -66,6 +66,7 @@ config LOONGARCH
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_NUMA_BALANCING
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
-- 
2.43.5

