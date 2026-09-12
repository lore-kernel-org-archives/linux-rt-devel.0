Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1B392C48
	for <linux-rt-devel@lists.linux.dev>; Sat, 12 Sep 2026 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242972; cv=none; b=Q+s6GlCHh/ePdPyoEkPkw37ps6+OQE8R/RJMjjtJjz2T59N2YhKpDHvKaB9gyimVM3ifjrApHrC4Gukwq6Nln3G8xTgQRWWsgO5/gobkBQ0E4Ej0UUWcQQip1YwznweKyHlFgQer+nY8aaZvD0Gjew535vaxJOriuMRayUqfCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242972; c=relaxed/simple;
	bh=rN3M/EIKOAXQYOqvo5H5srYi0ltpPT+F1jN5KbTizKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StzuTP3CmQzgdEp38dgMXNWTp0BoAuFhr2pGa32CrSZJMrdoQ2i1zSio5gQ6GZSW/t8HnsEZKsNGCFbzaOq2mpkwXWwMH98CxhF0ySQ5iFKtBizTy9C9GCnIucUxUSxNmm5sVIV4zeSz5Xa54g+W/b63KriVnTfh6fXGMz5Qlug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiohOYaX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiohOYaX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso25223745e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 12 Sep 2026 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242964; x=1789847764; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SudqM4dinshG/ga4dKzazwfwaSNRtgAeUisYk5patHw=;
        b=TiohOYaXJdlxeI9RyF0CBlIj+GcWXAxz0ftXEEWxFtsctTteZaX0xrfYPonAt9pjJR
         dLO3RtQ7lVwfPRt0UMXNwb9NVleWXxVWMUW1sQmvGPHC9PlU00jyhXTE9ozzo0JPGRaj
         jDa9z9NnUKLCpG1xkA3YkBTXNQElKoK4WIVjxxmowj+A+ISExqia4nmqI46zMDpuBfDI
         w4Uqg/9ltg696tD1sjH2qnrZ3isMgeY1lGlZh4K1AEtnJLtXYQAs2IsnLJOGR95RJswx
         Pe23PzqmWR3SYFTNp4HhlSTaHbQJHSKgzyJ9Se5pVmKPX0F4wG2GOjPIHiBDpFBD0j1O
         svRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242964; x=1789847764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SudqM4dinshG/ga4dKzazwfwaSNRtgAeUisYk5patHw=;
        b=BEzKUWB53bfF+TUg1xbhoPWQ1fbMkse3VmqaCi0lKjqf6r4p9XR7d8eucoNLirM4Zu
         E6495en0rHDbIkvsegzC6QhPh2Oz8XNqGrn5fUFr1/9+zH4a1yoIdXrfDC+ML4VKyOnY
         KEgcBDcn/q93IasoxjZZsPG0WD4ab3oi/DAjMWHVPM6qyTS/rptLI1yrtTWB9WNhsBgh
         4RqTrMxGqH3uQJZDdMveED9yKToX9zEqZCEdGLacfVo8vY6XeFDLrxChS/GRst4mLXYu
         Guh67oTE/zv3xBGTN8Lh+FYyguoQMRwWtYfM9rE7xNo3eH/XDlwbcNMjFv/FdZM2fLik
         wzFg==
X-Forwarded-Encrypted: i=1; AKwUvBzNKQqyjwJzF6vVxBDIuaxYudHTT7A5v3QPmiMdeIj2FTvfhfdxzU8Xqw5x88vZQMVH43RlAMLSq1RQgJYgFw==@lists.linux.dev
X-Gm-Message-State: AFuF++nrvyLoieP7uIhvn3EKqCAj22prpQU++msK+NTrkPZSD44HMllS
	pKyh4MbVvfU+qzDQD4Y0BGb1OFI3AU6DqxRwKDq8ucwDztlwyqBzblFf
X-Gm-Gg: AYBFou0qE98PzfxwqYIIzIfx/9aNBVVvI7nu2niW6Oe2wLsG49TZ3zd3owfE9rz2JfY
	0I6jobcfNvi4X4T/M62TLONe9UOcrReYDUXKMMILsmlkIJGr4UlHstVb215mBaNsyuxjRHyyBC9
	/dxDRFFfHaP+1vz7vmezC1nmgpTaKFkdvSqP3SJi5bCj0baj6+traWQK7e3ZsTQADZhyulzu2aq
	Zsy+M/0Q/ahZBmtljcEcl5dGDE5SXQ06kUkRyR2/Q2BLFG500uGHW5WmydKAcBuBceZjKRoEIxo
	FxY84WY6c1R3v1lkgXPGvyTC+7EyG/xY1F/ayV1/QMp1LBuswsogaB96T/oJJSe/O7Ay6UMgs5Z
	TMocwEHWXgALb3Rc3C3tR9kPD/706+/8igZFcq9dYKx0sU9FdXrXOUm27mZw25R2s9igVjhfUiu
	VMAWNDLBJxaTnEbsgL+sTs4VIHIggUDAsDisePdLKiuBdHYN7GBmMKHce2U2eZLD2FGBAI9EoR6
	AUbrCsny5K5vzJJUNtzA3UkKeZVb2VSz9FeBQpWwBivAnKUPQciy/yJe16I+F7ksGleBg+MRpDc
	aRQBPtJbhoUVWyvws4Zq8Y+oTxnIs24HWv/jUTbLZycfiNuaAEpYiLO+OFr60J2mpN/3mqEODRJ
	CAX7UZmkY
X-Received: by 2002:a05:600c:3115:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-49e61989e79mr109783245e9.10.1789242963500;
        Sat, 12 Sep 2026 12:56:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm267089045e9.14.2026.09.12.12.56.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:56:02 -0700 (PDT)
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
Subject: [PATCH 4/4] ARM: topology: allocate the cacheinfo early on the boot CPU
Date: Sat, 12 Sep 2026 21:55:52 +0200
Message-Id: <20260912195552.76673-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912195552.76673-1-kmehltretter@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com>
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
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
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
-- 
2.53.0

