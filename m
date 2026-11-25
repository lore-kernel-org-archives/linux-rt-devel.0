Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579431;
	b=Dzw5KoXSZJOaj9XuY2vqB2SoP/igPZG1A/X9AyLALgFjPd+SRZW2LafUzi++v89LN/U7
	 vOA9rlI8cFAbhmgdcf4mYb97uvcW/e3BnOea39x706LDsR3KqxhYmkD4DQe15PCEaWpGE
	 suO3xU/5kuBce+DgAsU5qt/vQIp2kq8yDW/hLUnQiemZkZgcT+qbUQJRrbEsauyX7Q+1g
	 LPJGnYjXHKKZjn0/ltSe/jhgLZErqtiSSMHltv/hZDS4bNiyQL+MVpaLPXN6Nimc1Hcqj
	 uNdwsqnfd+UANrpLFDw2d+yX2cDaz+4LaHQozb6qLFvUXX1r6e+J0ePFXG63PwyGI2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=FJpFlG2KhF/i7ZYFbAbjEhsaAMAjHqUu1cyD0w44kPw=;
	b=zN/CIwylaEuDmieW/H7gbNsXl1DoV3zvJvKZo1PAGK9Z+rNnzAg/tPLODExzWAUNSzKd
	 6MzoexSRhVJt/DKp6R36uIA8tGNbpK8epJ6kdN+5IExb25Tn4OGj/Rdz9BvuT9kLOVqrF
	 UmRuy9w1j7Ve7Rt7PSfd/1+ov+WgRwsUAjUFKzCa/kddmS8CWLXZSlBtv9QnEOPqkSc2M
	 bTCREI0JfOpNNJ8QWcFonnPKHwA4QkGPy4jar7dZIpJNDhsoBsxER7tUYFiW/a+6jA7dA
	 oR9Fu2P4XzDivvkJDCY+a1/2Qh/YoNgpuX36WIecBlwgCUco1rdgXpqgUCc5KpD2+ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ko3JLYaK;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61880606A321
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 04:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61880606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ko3JLYaK
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b2382bf051so2919033b3a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 20:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579431; x=1796184231; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJpFlG2KhF/i7ZYFbAbjEhsaAMAjHqUu1cyD0w44kPw=;
        b=ko3JLYaKUjeuhdwWw1Q31yx0LIfMCScd9otZmN9tqdP8cmqHiJSBq/GrYJC3nv04Ko
         ZHuxIoRyuNhYDMxImGaVhNE9MW/XzH493GKIORPqxKRpqePONaV1hhKSNaZBMrTyesMw
         h54jJEFJaobKJoHbaOgfKDW9XNFsnS8Q3XpMU9TDNz+lC3KpF9RhCstLnuiwFTiYpPLy
         mKwi7iwNFFawbBCbfoVqRQVTwwDdUwR4ZuxxVJ17TDQGRI+XNy8qIk+sCOnywKU9DgdO
         oE8HWqddCS+jcFZZBMvW9XRNjsmayQ/bxVQuYLB+BiiHv5lsrB/NfhmKFO2AVm3ooUTX
         XIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579431; x=1796184231;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJpFlG2KhF/i7ZYFbAbjEhsaAMAjHqUu1cyD0w44kPw=;
        b=eAqoHOZwieD9BNRwizTfEZw2GKWH599eSkkpBl9wK4mY4d7/sczLxGiUfsQZRylwMY
         FHqm7yv0QT15ahCaP3nfiTU/y6gdmBZFW1TLdW8VjFo/SEWTFqndZh6QNLwKJXTiR0Cy
         5txL0m6BM+seZFyBtxtYdE9Fot5xnG82gW/nGfky4WABRNOotrWz6Ws2okjUcW4lWjyc
         lYkhPkpYV8cB1mtg8XIXzBT/vvzWRC9JsGZaSrOR0l9aYZqc4hths24zhe6pH1vc2ftN
         3jsL+njch6oeB49KfZuJvg39JLmRZKNQNKd/ErfHtmh7EUaISHi8UuS0YVv794vvwIEW
         T5gA==
X-Forwarded-Encrypted: i=1; AL+hErFoIQs76i5pR+YuUJDElCUUkfKPe/57JjKZjvji/8qpARq7Eh92X9gCvm4QfBVZt4eIqV4jg7Le3GWylotU8g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9khJEdD4pexKousDSzlsKIk3fe+fpGegZ8Z0nxN965mkhG3fBg
	oM+SJB9YBC8XqO2XGn6W+xCf2HkLo7Hjh6NO20VxVXiUbXHnuGLXCGKK
X-Gm-Gg: AZFdTZeubSUxcbTV6PHHJRZXTf4w0UdUpZTwMxAXiXa3zTpycNyflbmj4AkrZUH91zY
	7IIdTEckkAvS1hCk6AlJwHGgx2JdjlMK9nvh5qA4D+eDLineYLlfjWtQWoSDtyZLTOIvAqFhXtf
	jFDRv+nUimMGTGo5jeE0jyKjyOHW+v1P7l1L7IP/o0zb4BhIHNREy5I6H+BWNfnsaYhtK8ffLY3
	KhmXXMJwpYKAw/AraOpyYUyeu+YUTsNt2OUYXD+zwcCsQClOjRMhzEEHrhgTiMIX2r2vBHHymBA
	fbZOKDpzZUDiMXWU/vN2nV25t9vJocMkR6uSPbKTEB1HwP+QZN1oNCoArGECpMb3B15Ac1P3WsG
	W8r0LxxQl7W5hnE+UjcrIJkRTHsLyZKhTsoejk1vNTP1hICp/1n3xDURVQBDhnEd//INUXWdiKU
	XI/bPvHI4LV4czAZkDzh6sxW02JzXn1LRlrKIaeu9MrOAOvDWstzIWPE8LgTmzczLrd7pZNkFxo
	6bb25Z58r6amOLZmjK1YcG0ouw/IoOQ/kJSOugYD/aB1SZC86yLDxmXIv99Aqu3fdxhgc+5yPQG
	fFpsCHUVJORGHMbFRGkuBHbT2v62sm4IeO6Zz7uXJ9K+/1UIAEwSjLaH7uu5meWvXO+3GTH4S1A
	2sm9G/qPkVqZ5w+cXqieyCBc9oVtuLWn/zA==
X-Received: by 2002:a17:90b:3a4f:b0:3ab:5758:3757 with SMTP id 98e67ed59e1d1-3b41c98bec2mr15855830a91.61.1795579430408;
        Tue, 24 Nov 2026 20:03:50 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b495035339sm12649812a91.0.2026.11.24.20.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:03:50 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:03:49 +0000
Message-Id: <DN3ZSA718QIA.11EAQE8I69WJ8@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo" <harry@kernel.org>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-rt-devel@lists.linux.dev>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>, "David Hildenbrand"
 <david@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <awWRZ9xCzWLnj_R6@thinkstation>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 05:59 AM Harry Yoo <harry@kernel.org> wrote:

>> +	/* The caller may hold a raw_spinlock_t. */
>> +	lock_map_acquire_try(&zone_nolock_map);
>> +	spin_lock_irqsave(&zone->lock, *flags);
>> +	lock_map_release(&zone_nolock_map);
>> +	return true;
>> +}
>
> I'm not sure this is a better solution unless this could be generalized
> or abstracted further.

Alright. Here is generalized one.

diff --git a/mm/internal.h b/mm/internal.h
index 85cf7be..1de6292 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1688,6 +1688,44 @@ static inline bool can_spin_trylock(void)
 	return true;
 }
 
+/*
+ * An IRQ handler can allocate at any point where IRQs are enabled, so a
+ * _nolock() caller can wait there for a lock that is IRQ-safe.
+ */
+static inline bool nolock_can_wait(void)
+{
+	return !IS_ENABLED(CONFIG_PREEMPT_RT) && !irqs_disabled() && !in_nmi();
+}
+
+/* @lock must always be held with IRQs disabled. */
+static inline bool spin_lock_nolock(spinlock_t *lock, unsigned long *flags)
+	__cond_acquires(true, lock)
+{
+	if (!nolock_can_wait())
+		return spin_trylock_irqsave(lock, *flags);
+
+	spin_lock_irqsave(lock, *flags);
+	return true;
+}
+
+/*
+ * The caller may hold a raw_spinlock_t. The map has to cover the critical
+ * sections of spin_lock_nolock() up to the unlock.
+ */
+extern struct lockdep_map nolock_wait_map;
+
+static inline void nolock_wait_begin(void)
+{
+	if (IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING) && nolock_can_wait())
+		lock_map_acquire_try(&nolock_wait_map);
+}
+
+static inline void nolock_wait_end(void)
+{
+	if (IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING) && nolock_can_wait())
+		lock_map_release(&nolock_wait_map);
+}
+
 /* char-mem.c */
 bool file_is_dev_zero(const struct file *file);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2fef409..f22ae49 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2550,7 +2550,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	int i;
 
 	if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
-		if (!spin_trylock_irqsave(&zone->lock, flags))
+		if (!spin_lock_nolock(&zone->lock, &flags))
 			return 0;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
@@ -3237,7 +3237,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 	do {
 		page = NULL;
 		if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
-			if (!spin_trylock_irqsave(&zone->lock, flags))
+			if (!spin_lock_nolock(&zone->lock, &flags))
 				return NULL;
 		} else {
 			spin_lock_irqsave(&zone->lock, flags);
@@ -8115,12 +8115,19 @@ static bool __free_unaccepted(struct page *page)
 
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 
+DEFINE_WAIT_OVERRIDE_MAP(nolock_wait_map, LD_WAIT_CONFIG);
+
 struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order)
 {
+	struct page *page;
+
 	if (nid == NUMA_NO_NODE)
 		nid = numa_node_id();
 
-	return __alloc_frozen_pages_noprof(gfp_flags, order, nid, NULL, ALLOC_NOLOCK);
+	nolock_wait_begin();
+	page = __alloc_frozen_pages_noprof(gfp_flags, order, nid, NULL, ALLOC_NOLOCK);
+	nolock_wait_end();
+	return page;
 }
 /**
  * alloc_pages_nolock - opportunistic reentrant allocation from any context
diff --git a/mm/slub.c b/mm/slub.c
index 5c33d12..5bd00d1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3821,7 +3821,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
 	n = get_node(s, slab_nid(slab));
 	if (allow_spin) {
 		spin_lock_irqsave(&n->list_lock, flags);
-	} else if (!spin_trylock_irqsave(&n->list_lock, flags)) {
+	} else if (!spin_lock_nolock(&n->list_lock, &flags)) {
 		/*
 		 * Unlucky, discard newly allocated slab.
 		 * The slab is not fully free, but it's fine as
@@ -3939,7 +3939,7 @@ static void *get_from_partial_node(struct kmem_cache *s,
 
 	if (alloc_flags_allow_spinning(ac->alloc_flags))
 		spin_lock_irqsave(&n->list_lock, flags);
-	else if (!spin_trylock_irqsave(&n->list_lock, flags))
+	else if (!spin_lock_nolock(&n->list_lock, &flags))
 		return NULL;
 	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
 
@@ -4543,7 +4543,7 @@ static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
 
 		if (allow_spin) {
 			spin_lock_irqsave(&n->list_lock, flags);
-		} else if (!spin_trylock_irqsave(&n->list_lock, flags)) {
+		} else if (!spin_lock_nolock(&n->list_lock, &flags)) {
 			/*
 			 * Unlucky, discard newly allocated slab.
 			 * The slab is not fully free, but it's fine as
@@ -5608,7 +5608,9 @@ retry:
 	 * kfence_alloc. Hence call ___slab_alloc() (at most twice)
 	 * and slab_post_alloc_hook() directly.
 	 */
+	nolock_wait_begin();
 	ret = ___slab_alloc(s, gfp_flags, node, ac);
+	nolock_wait_end();
 
 	/*
 	 * It's possible we failed due to trylock as we preempted someone with
