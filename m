Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D33E1729
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873486; cv=none; b=IbnQVzzkBBpwujVry2t03tJK5VR/fpf/HbTPvPToNa9CU6uEP5EvRPh0IizSwGphE77iYPX/oUWi/Mz7NXZNCFsx7kX5fEYU0T+HtHzGezPrDH8VsM5AePyBnXEWZ9mB2zpbL4rxy9spXAXHI9FKbyqwgERDMAmOPw4vVRD7Kys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873486; c=relaxed/simple;
	bh=K+D5Y6brOLXG1aN+myxhErHXOB0qjYSBze5FnYnXukE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G7c4WDRvYOh1jKh8BhkqeAAf4b62WbbcFluQFFWmy8mOFmCycNMoBLDzCbxpBWg9AIemA252Gw0kfxJjeKM8ku33tzEEh8ROpTTT8tgJsW8m3kiSqcH9whZ85yIPcHAeU5mQxNvVrJZp8eVmsjOhiCNtspFHxsH5XOWyWy8RV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAzGK2y2; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAzGK2y2"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39512608fb1so1060084a91.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 16:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787873484; x=1788478284; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOrBCjVl+Gsil1QM8OKlKDVjeh9PhasgM5tVDAHOOrA=;
        b=eAzGK2y2uB4M9WApMDUrnI+QNyYi67KcGbWeGj3yXEVC4CZPGoz4CayQKPtodXG71L
         bnmF6GXZTZjmaqq/lqf30U8ivsaL/fFPXWkVjVGjwUtxHnroxlkA1Bv5yyNRRAOV9KbW
         +878xES4F7W6SbmDUXuEbF3+dr5DKWHdDXYc4XwuWD2hBIbCwgAntHsdix5P2QMKA/zf
         rCmWPJcu69y5STyFgak2CWT8F8E5QTKYuuI0TCYhfDsE7SzJ2AwKfbDNyoTQqcMd/f5a
         FTLdJcy4sJ153Xj9R3Svq7zHiBN2/ikB5UN3o4P503GKRwGg4vIiqmAGT5Mt+svQ/yOL
         NaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873484; x=1788478284;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOrBCjVl+Gsil1QM8OKlKDVjeh9PhasgM5tVDAHOOrA=;
        b=Z4G4riojP+2xYQidnC+N250PXT4Q97uyAVVc05OI17KJhojNfuAiug/ajWh4rdDIcx
         LLi6g5xtZoaIws1zhM/wzILnjl8eVG5DUiUu4vIdmSXg5sOCPLJMmMG4XEaKItVWJp86
         NvX2wQV+SmFjckuBjIE7C0BDOC9FF25JD5+MnNAYA+9DeFlD0eklGHRQVjdRgcuhev5h
         15GHqWO+RoQmmZD8blM4pNO7eYLc9QK9XS4+zj8JRcyoz5VrTa8t4CZ1uZAcRoFJ6T/q
         Df56lAGNIprjAE/yo4MJIPosrnXFO/gyo4Zy4uO5RZx6wwHoREcmNnpLHDXec0duHV6f
         SOBw==
X-Forwarded-Encrypted: i=1; AHgh+RrSeezCMvuF/z6VgGV4HG/cO9aG/SaE5RMDHZsSROuPtNTzfoZ8BjEiAnXMEBx1xG9aO7Iao63kG1h/L4NpMQ==@lists.linux.dev
X-Gm-Message-State: AFuF++miTGGEQJp8fTjzQQp2AdFY0W5A5aVlUnprHCpB9Gp9Snyit9Jc
	vCmXWdU0ofMP0xxYN48efiVFtfE4JN5jxo04SFtJFeJhVKP7LoAeRwi1Wrh0D92TMzOMskSAR9n
	3RhMmT7B1S222KQ==
X-Received: from dlbqi2.prod.google.com ([2002:a05:7022:ebc2:b0:13f:bdf3:f58])
 (user=stevensd job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:4cc2:b0:396:d27b:89b9 with SMTP id 98e67ed59e1d1-396d27bb20emr3178120a91.10.1787873484126;
 Thu, 27 Aug 2026 16:31:24 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:29:42 -0700
In-Reply-To: <20260827232948.2520558-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827232948.2520558-5-stevensd@google.com>
Subject: [RFC 04/10] mm: vmalloc: support creating aligned vm areas
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

Expose a get_vm_area_node() function that supports passing an alignment
when allocating a vm area.

Signed-off-by: David Stevens <stevensd@google.com>
---
 include/linux/vmalloc.h |  2 ++
 mm/vmalloc.c            | 24 +++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index d87dc7f77f4e..5ed9c5b25026 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -246,6 +246,8 @@ static inline size_t get_vm_area_size(const struct vm_struct *area)
 extern struct vm_struct *get_vm_area(unsigned long size, unsigned long flags);
 extern struct vm_struct *get_vm_area_caller(unsigned long size,
 					unsigned long flags, const void *caller);
+extern struct vm_struct *get_vm_area_node(unsigned long size, unsigned long align,
+					  unsigned long flags, int node);
 extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 					unsigned long flags,
 					unsigned long start, unsigned long end,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d39897300f29..059cd0748514 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3280,7 +3280,7 @@ struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
  * @flags:	 %VM_IOREMAP for I/O mappings or VM_ALLOC
  *
  * Search an area of @size in the kernel virtual mapping area,
- * and reserved it for out purposes.  Returns the area descriptor
+ * and reserved it for our purposes.  Returns the area descriptor
  * on success or %NULL on failure.
  *
  * Return: the area descriptor on success or %NULL on failure.
@@ -3301,6 +3301,28 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				  NUMA_NO_NODE, GFP_KERNEL, caller);
 }
 
+/**
+ * get_vm_area_node - reserve a contiguous kernel virtual area
+ * @size:	 size of the area
+ * @align:	 alignment of the area
+ * @flags:	 %VM_IOREMAP for I/O mappings or VM_ALLOC
+ * @node:	 node from which to allocate data structures
+ *
+ * Search an area of @size in the kernel virtual mapping area,
+ * and reserve it for our purposes.  Returns the area descriptor
+ * on success or %NULL on failure.
+ *
+ * Return: the area descriptor on success or %NULL on failure.
+ */
+struct vm_struct *get_vm_area_node(unsigned long size, unsigned long align,
+				   unsigned long flags, int node)
+{
+	return __get_vm_area_node(size, align, PAGE_SHIFT, flags,
+				  VMALLOC_START, VMALLOC_END,
+				  node, GFP_KERNEL,
+				  __builtin_return_address(0));
+}
+
 /**
  * find_vm_area - find a continuous kernel virtual area
  * @addr:	  base address
-- 
2.55.0.897.gb25b4bd76c-goog

