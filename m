Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6A364E98
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970432; cv=none; b=GNTw7ZjWQp//jKJVCl4h/S2Lp1wzhYkyNL7ST2h/deBNk9bxliQNvfSFDIthWuKEnpXnJ9xgQlbI7+7uGHCi5Izf8qarHJKeDB5wbNKg1hx8isKXTmuCxeUNvxURYE8CWO5+Y/p1sopi17SZZ8vqD5+TeTGaOY8qyj8bHmr9fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970432; c=relaxed/simple;
	bh=8fGm4QsbqboQ4X+kQYJy2qxs1YmyCSH63xzjYCEY+NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IWyDUJqDPIucBPqui1Q1iUhK0XFfHJVQn/hs/PfL92C4x1mFghl5zBZA6JfOFM04wr2V9PbNxJLGuRUrDKRntSbkXH38/t8gOUfcqeHvb9kCfK0w+5ttWMkWIZZMPpnYaYMZPgZxgWrGWRXVfhLnJanbZ2x16UHArr8e9WFegWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS2/eux1; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS2/eux1"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d097b4939so12263345e9.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 20 Sep 2026 23:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789970429; x=1790575229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BSUm2BvGMfGtlmppCZN9JChh915ltc85tdW86S+ilyw=;
        b=JS2/eux1woold2+dZxy9plMPmIrYWvbDjG98NBKmnYBpFZXs1QACwxVTYVft0nYteD
         570sgpKM7iml0g2MyKPFRBtlUTO+ntuLf/CyqTe12YER1Vxiaw6vsbT7NDWcyPzFuY9S
         EmKfjZbW5Jfw0bPI+NodZKHbR+7Ize0mtaRDOgXgSD57r/PIhclhkF4r8u74Je+aj4Nn
         ObO4TxPstQBLtNnAGc8BnOl/10U/AiLOZ9WW//NCNlenWkqC83NVs0w4B+6jTk/zkweX
         sgeZsgVEw4ZpQW8PUyNoKnYZQ39RMy8Fk7MIPlHPjFChbyS/MMpuKGq0lAf80SWH2YW7
         QLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789970429; x=1790575229;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSUm2BvGMfGtlmppCZN9JChh915ltc85tdW86S+ilyw=;
        b=CQ5a7GEzx48+mo75WsDOmASbC4Oxe1sekWLXXafUquhxXth+5Zm8Gerh2fYTXJikzQ
         K/Mrkv5gQo1+ytJKol3q+YPAJZMmwWRU6Kx9IoelHRoM4m5zrVNEVailfQPPfITR2kx8
         ymqneoKk44uGHL1NHy1AsOx4gqZ5Fb2sXBrhvDfyJtrYkDpqFT4Tfb9NLkxW8DtUiswk
         nJTjuBfHQwrNp71i5aBR4PU4QKfVDZdVPmH4idsVbEPtr1aQ0g58hgk2M36GtbnJ1Gxy
         0BYcuyebeSMBjLmE7Fg4bAo+4/+mnoWSVS+EbKjm/t9768sJJNfQ1IOeLCuZn9eolBjD
         Xvgw==
X-Forwarded-Encrypted: i=1; AKwUvBz8DWrXFmRf7wjxv2fh7VkR0rl42J1Urs4/cddTk6+O3Lr2AvFYiAxigvaWlyXDUhAnEHIKZNdJXnTSUA1oOw==@lists.linux.dev
X-Gm-Message-State: AFuF++nRLSrP/EMP3jR0NZPJ1RivmHIy/p4B2FQBMYCYi3koKORtixJ8
	/lqYPuqgr1nqk6pHZesQQD3f1U3u8Ir9S3VTjcKaSNfqkFajjLQ7jAoF
X-Gm-Gg: AYBFou0/HvQccp10LgxRBOyG1eGzyGDWZnPin+8A7hyhxfJWfNSZFwaZylDQ0ow+Cnj
	SGckEM+cizITgZeU025DTuODlliDP2Uiol2JUe0VZPwlLLyhi9yONN/hkP+0OeEj1G9PBBbQorT
	X1EcFfdYxbNaQLA8c+4FAFHK7kQOIq+2SYSuV9mnX3ravC/nC14PRMiBiZ+HwtViMbHo0DIwXg3
	wc99yLpkWIMjwiZiBPYX1/5ENoJKcfwKpWJVttNAqjtz1HdfgihF4UI8uS9vMNbXKGw9mB/z4xv
	UxppPk7pDWADIA7JsXD8opDjd7vieaFEBPj1lck4lmowKxQX6hZ9AEZD1q2J7JiGgV1OD2E2spS
	DKrfOHoCaYU7k7poYlHcWvrnU3xDVORJPFpiTsoo7LcN1li4Cbpi6IqrA0FdT60Jju0nt5m0Jvu
	msOrkEFfPqXDjn/D8WawISaoSU8issemoeybpbSI905/Gf8l/zRYnZpwv54Nv1GKdWlfI7UgY1u
	4DXEgoSavGLMbnAyYkorhGz9nirjI61iJ43xrBOArNuGMyLLH/8KBvH6CYhei4WoFtfAvlH8Nb7
	v6FZhZ0kdYxtOHKRHaGhDap9sr+YHPSTwZv8fNR257B2mxe6lMEkCbAw+XwM7xntBHJ6k1F7L+K
	6bQ==
X-Received: by 2002:a05:600c:19cb:b0:49e:8184:f619 with SMTP id 5b1f17b1804b1-49fc57410f2mr132387185e9.22.1789970428604;
        Sun, 20 Sep 2026 23:00:28 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-f941-243b-87f6-e5a2.310.pool.telefonica.de. [2a02:3100:a8e9:c501:f941:243b:87f6:e5a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd1149e0sm198706585e9.13.2026.09.20.23.00.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 23:00:28 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: topology: allocate the cacheinfo early on the boot CPU
Date: Mon, 21 Sep 2026 08:00:13 +0200
Message-Id: <20260921-arm-cacheinfo-v2-5892c4531ad9-4@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com> <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com> <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM secondary CPUs allocate cacheinfo in detect_cache_attributes(),
called from secondary_start_kernel() with interrupts disabled. With
PREEMPT_RT, the allocation takes a sleeping lock and triggers
"BUG: sleeping function called from invalid context".

Call fetch_cache_info() for each possible CPU from init_cpu_topology()
on the boot CPU, following commit 5944ce092b97 ("arch_topology: Build
cacheinfo from primary CPU"). This supplies the arrays before secondary
CPUs populate them. Suppress -ENOENT and -EOPNOTSUPP, which leave cache
detection to the existing late path.

The CLIDR fallback uses the boot CPU's cache geometry. A secondary CPU
with more cache leaves can still require late reallocation and trigger
the warning.

Fixes: a9ff94477836 ("ARM: 9433/2: implement cacheinfo support")
Cc: stable@vger.kernel.org
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20260912195552.76673-5-kmehltretter@gmail.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Fresh full-series rc1 retest: three builds and seven QEMU boot/CPU
hotplug checks passed; see the v2 cover for the matrix.

The detailed testing below was performed for v1, before this rebase.

Full warning on QEMU virt, cortex-a15, 7.3-rc2, PREEMPT_RT:

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
  Call trace:
   rt_spin_lock from ___slab_alloc+0x68/0x728
   ...
   __kmalloc_noprof from detect_cache_attributes+0xe4/0x734
   detect_cache_attributes from update_siblings_masks+0x10/0x174
   update_siblings_masks from secondary_start_kernel+0xec/0x120

PREEMPT_RT became selectable on ARM in 7.1 with commit c6e61c06d606
("ARM: 9463/1: Allow to enable RT"). The PREEMPT_RT patch queues carry
that change for 6.18 and later, so 6.18.y is affected as well.

QEMU virt, cortex-a15, PREEMPT_RT, 2 and 4 CPUs: the warning is gone,
the cacheinfo sysfs tree is identical before and after, CPU 1 survives
an offline/online cycle. Same on a non-RT build.

QEMU realview-eb-mpcore, ARM11 MPCore, 4 CPUs, ARMv6 plus ARMv7 SMP
kernel with PREEMPT_RT: fetch_cache_info() returns -EOPNOTSUPP through
the CTR format check, no message, no cacheinfo before or after, CPU
hotplug works, kernel messages otherwise identical.

Raspberry Pi 400, four Cortex-A72 CPUs, 32-bit PREEMPT_RT 7.2.6-rc1,
full series: the boot warning is absent and all 12 cache sysfs entries
match the unpatched baseline and earlier topology-only run. The live
DT describes the shared L2, exercising DT-based early allocation.
CPU hotplug is unavailable on this platform.

 arch/arm/kernel/topology.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 2336ee2aa44a..e6b50cd43ce5 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/arch_topology.h>
+#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
@@ -238,8 +239,20 @@ void store_cpu_topology(unsigned int cpuid)
  */
 void __init init_cpu_topology(void)
 {
+	int cpu, ret;
+
 	reset_cpu_topology();
 	smp_wmb();
 
 	parse_dt_topology();
+
+	for_each_possible_cpu(cpu) {
+		ret = fetch_cache_info(cpu);
+		if (!ret)
+			continue;
+		/* CPUs without a usable CLIDR return -EOPNOTSUPP. */
+		if (ret != -ENOENT && ret != -EOPNOTSUPP)
+			pr_err("Early cacheinfo failed, ret = %d\n", ret);
+		return;
+	}
 }
