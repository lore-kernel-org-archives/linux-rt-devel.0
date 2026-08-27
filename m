Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351F3E1680
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873498; cv=none; b=DpozYMLSM3S/87BjYx/Dwc/GKVDLf2bI4BnnR0ftu2y/mOQ9/dveVZMbKTR5VtOXq9D7bZaHdyJb/z/Yb5fFSbbh35VxvVkEn5LmSVZJqY6YggDgyZDpDN7yJj/iopeFO2m9A4cAs4R+jZjHZs0NFxZ6cXK78PgZQy/u5x4qHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873498; c=relaxed/simple;
	bh=a4DHxg2eDawzpdV6ihnCiTe31A8NEYh6oPRQKJtlYWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QKH/Y/w0+IoVhDqFGyg6SvLCHzS1c04SsENJi2MXCiQP0FnZSBLgKJ6aj+EhyVUqjVx0ql/aaBoSqkxTl/R8xRbGFZIB8x8IbyL9379ya5xQGt9aWbZPpVWutsvgyEUJpvBhud7C7/f+6kcB04mdjwyyhn8vAVfXwCnrq4e0ZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IrEYzrZR; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IrEYzrZR"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso806938a91.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787873496; x=1788478296; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THehtAVXPzXeOISNI+hN8Wh32bn5y3s9ZVH/HPQs5Ig=;
        b=IrEYzrZR9vZyT7kt5PoldbZw2n95qlCphQ3CTn96H3KoXOHGZBHVqTlrDaca8n0Zrb
         ePLQRBq0KBEx7cOg2n6GZiDbKn8U27KNqMjvuCT/GzjNcjwARbAYA0bspQkq1qKSA7ih
         oiYgmKIkINaD4qRnONqCNUzMjfxzfYVbejlbO/0aN+g6viOlcK4Hbcg3aYuC6jrzFP7H
         qtfi7UzurWLABL4IIBu5pbV2be1lc29MROmYQEd4noy8suEZarxvLz8xmA7wz0T1GXc2
         GCsS+i7AL6M0HJcpBWxM5BuLKgVlZRa3V4GAt52XHRJjCFVvSKjS7gsd5aI31xhlko2M
         NBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873496; x=1788478296;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THehtAVXPzXeOISNI+hN8Wh32bn5y3s9ZVH/HPQs5Ig=;
        b=UUnM/AaFtIqxuMvl7djYOZ0mD/8nag5KU+Z+vYE7hKnBdUX1CIui0A9Z30fGDP5DBr
         wj7eODDRicBPiM4nGOmDIOoKr8acvP+/BSMaoHMRvZwgXk4TJpwYHA+ec5CI4TN8gKGi
         S/gA76ILDIv61X+hYmLM8sAi0TtM2Be+YuxE9Q4q9IJRHuuR5mBF/u8750R383Fwz4/C
         DuaunDuw6BKuEz6NYTSy6VJY/9kTL/Q6giU/OrMKPkztD6LuLYwsC4ivP/FGRnhvK/Qb
         B0wrZ+Hjes+KGPx6peShHcDIL5GYbrbbNnnZTyrc6MzBELw7+ey6wd2h1HOFdF7ddAfA
         7A0A==
X-Forwarded-Encrypted: i=1; AHgh+Ro46qQE6XwlDoY7f4+1vXAx0k+OwTYmv3Td9A1RHeeZML91v8YzfpuFpEk4jR9DtLdhykaaK561RgvvsC6xCg==@lists.linux.dev
X-Gm-Message-State: AFuF++mVLgmCBe1ZyCSGjhcgXuZVQb7xMsWwksu32Bmcf9zsVFqjNSe7
	JrgpBifsNYWYrEZSoK9Zi6dfmnOdpZiwuq/5mXoHqiH+bpEaAoHxDTogm+xTpHmZmr+5q3IV8cR
	dDZjkZ1sABD7fDw==
X-Received: from dlbsj13.prod.google.com ([2002:a05:7022:f90d:b0:139:d9c7:3cf4])
 (user=stevensd job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2c88:b0:396:b98b:a3c2 with SMTP id 98e67ed59e1d1-396d0f52a0amr5303479a91.8.1787873495813;
 Thu, 27 Aug 2026 16:31:35 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:29:48 -0700
In-Reply-To: <20260827232948.2520558-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827232948.2520558-11-stevensd@google.com>
Subject: [RFC 10/10] arm64: Enable reclaimable stacks
From: David Stevens <stevensd@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, suleiman@google.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement top_of_blocked_task_stack() to get the stack pointer out of
a thread_struct and enable HAVE_ARCH_RECLAIMABLE_STACK.

Signed-off-by: David Stevens <stevensd@google.com>
---
 arch/arm64/Kconfig                 | 1 +
 arch/arm64/include/asm/processor.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3afe0688919..262a4fddce19 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -173,6 +173,7 @@ config ARM64
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_VMAP_STACK
+	select HAVE_ARCH_RECLAIMABLE_STACK
 	select HAVE_ARM_SMCCC
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_EBPF_JIT
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index c2a627f39314..f5a550835c94 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -204,6 +204,11 @@ struct thread_struct {
 #endif
 };
 
+static inline unsigned long top_of_blocked_task_stack(struct thread_struct *thread)
+{
+	return thread->cpu_context.sp;
+}
+
 static inline unsigned int thread_get_vl(struct thread_struct *thread,
 					 enum vec_type type)
 {
-- 
2.55.0.897.gb25b4bd76c-goog

