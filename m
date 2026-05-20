Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D7372EE2
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310032; cv=none; b=MBrEclU1FiJeA1anzsG2HNHnyxatqM8coJjRelmZ5AA6aOcJ7pKENflBx/2tsjDsLjd2QW1c0T2tTeSORoZ7T6H1oXX7LP6ZclP7dXAysRKZMuV9hGYn7ZBGNrMiHvIFczwfT4r6AhE1qmMO0ht2YCv4rotsyjXPmx4nF1urd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310032; c=relaxed/simple;
	bh=ChAozatgNptjvc+RxeK3kOyGKozxFleHwac8Lrrl5Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=SGERwIP9colB7LIWnv9uoMzcMuvvUpQ+qRa0H3HF05hlfTLvmQsU01S9qwSxde5Eb5hwGUKtfGGZPdqIAEibBCmLXdv/LF2KRCv4cpU3CEPrO5Jb0OBG73Q1QeluCdurmAApkLM4c5BRIT03W2vBjC0ax2I6S7gKmsZb9wY78hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUUs7Pww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUUs7Pww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779310029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1EyYbR+jhGOTsmqCZIrtN6+oCATdrHEFLzp24eY2naY=;
	b=OUUs7PwwTrOn17eT57htXnkubqqrfoOT7w2h4P6UoPnKZOgkzjGD3zEQvNMoNElpeMKAL6
	A2zaz9SYd24IoHQRJd5a1JheNO4hotoXHgQQcocicA22xd2O2w7a8+nCMJL8b1VFEeHPMs
	JyXvcExPTPMQdS8J6GipxlWEQCtPfCg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-V_6Urf5lOjC4rh9_O4x6YQ-1; Wed,
 20 May 2026 16:47:06 -0400
X-MC-Unique: V_6Urf5lOjC4rh9_O4x6YQ-1
X-Mimecast-MFC-AGG-ID: V_6Urf5lOjC4rh9_O4x6YQ_1779310024
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E2F8195605B;
	Wed, 20 May 2026 20:47:02 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.248])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB07730001A2;
	Wed, 20 May 2026 20:46:58 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] gfp_types: Introduce a new GFP_ATOMIC_RT gfp flag
Date: Wed, 20 May 2026 16:46:27 -0400
Message-ID: <20260520204628.933654-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: XzD3TeRrNWmCJ8txErTp4O0aUY9tAEwuABr-u6kSj3Y_1779310024
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The GFP_ATOMIC flag is to be used in atomic context where user cannot
sleep and need the allocation to succeed. However, it does not support
contexts where preemption or interrupt is disabled under PREEMPT_RT
like raw_spin_lock_irqsave() or plain preempt_disable().

With the advance of the ALLOC_TRYLOCK allocation flag in the v7.1
kernel, it is possible to allocate memory under such contexts by using
spin_trylock to acquire the spinlock in the memory allocation path. This
does increase the chance that the allocation can fail due to the presence
of concurrent memory allocation requests. So its users must be able to
handle such memory allocation failure gracefully.

The ALLOC_TRYLOCK flag will only be enabled if none of the
___GFP_DIRECT_RECLAIM and ___GFP_KSWAPD_RECLAIM flags are set.

Introduce a new GFP_ATOMIC_RT gfp flag for those PREEMPT_RT
atomic contexts.  This new flag will fall back to GFP_ATOMIC in
non-PREEMPT_RT kernel. GFP_ATOMIC can continue to be used in contexts
where preemption and interrupt are not disabled in PREEMPT_RT kernel
like spin_lock_irqsave().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/gfp_types.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index cd4972a7c97c..ac30882b6cd4 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -316,6 +316,13 @@ enum {
  * preempt_disable() - see "Memory allocation" in
  * Documentation/core-api/real-time/differences.rst for more info.
  *
+ * %GFP_ATOMIC_RT is similar to %GFP_ATOMIC with the addition that it can also
+ * be used in context where preemption and/or interrupt is disabled under
+ * PREEMPT_RT, but not in NMI or hardirq contexts. The allocation is more
+ * likely to fail under PREEMPT_RT due to the spin_trylock() nature of lock
+ * acquisition. So the caller must be ready to handle memory allocation failure
+ * gracefully.
+ *
  * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
  * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
  *
@@ -388,4 +395,10 @@ enum {
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
 
+#ifdef CONFIG_PREEMPT_RT
+# define GFP_ATOMIC_RT	__GFP_HIGH
+#else
+# define GFP_ATOMIC_RT	GFP_ATOMIC
+#endif
+
 #endif /* __LINUX_GFP_TYPES_H */
-- 
2.54.0

