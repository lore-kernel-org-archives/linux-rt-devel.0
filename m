Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB504483A3
	for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113427; cv=none; b=a4wpisuq460kgv6qLpJGSrNHwFqQRFgOmXkN7CIcaHKWPIN0SbzVG4lMScveQSR8HQX734YEqSnFjKEka45yZG7QLxkxZhyJ4Xxy7BqBNY8Kr7UfXRCJOkNjaOAcoEpW0e55WFxozJjs3xL1AJ6I7EtNQgqk7wOJlVEw4fo+h7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113427; c=relaxed/simple;
	bh=J6H+FoeqiU5MQFbzUvf2h1acD2Gc0AUhstmNBmOjGho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hVG9P1Fmmg1Bkwijcm3Sj0aJVgqmw2BUO5c1ZCxHyglFNoNXy1boQw4+aN6BHlWT9CxGJPrZxBC/4AEdUL57Wrvh+txzSdzq5Rmd0akxcU3bE7MH0MrtopMzTf+/CiA3GFvuRtAFJGEu24ByIJeNrUQ+BK+9HTErT5isNAf2iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O14EJb63; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O14EJb63"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so30319815e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784113422; x=1784718222; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dz86EwLqIg9rsRKy2+oVo0cZ8RAfDlpYQ8xyeR+GWfk=;
        b=O14EJb63FnE3SRfDdWg07wH2hNBDGuL2GFDaXs/JsKcohgycSoM2YtUQurXr+WZnCD
         9jj0tw9SaBWd7rVh4iML7pfDM0i5rVhYB2s8aNqlck0GoIVAKmo44nhEgISkHY37UM1r
         lG1EmhLSjyDQayZKJsMb6PCgYM+1Sfa3UhNvWD5hen9wRPU1NtI5o0w3CS6CBBFMbryp
         yqrizk45mzzFfgSOfcOKaGKEP3Mzmk+HiFY9fTHTOonvuBo6qm/5PDmP3MpvbfMNFo7Z
         XIKRCSsqfSLIYvbYclO6+12E4W4EKOS/031GCc5ZCMxI604DnrPNrhPw+qC49rfOQtpd
         9QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784113422; x=1784718222;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dz86EwLqIg9rsRKy2+oVo0cZ8RAfDlpYQ8xyeR+GWfk=;
        b=tZlHJDxpWtlhD0+hSJvzEI5rRAzugS0buAJoepzXGI8pwm8Mk8CY5OJniqpeaXIxYV
         6UhnjJIfl2Akj5l/FKdxGikCtpOfUPBKh71rgaZG0zPzI/A1KeOA4pA3TMjJ6RJjxJXK
         aWTEM2GWPzT78a0dDx9uuHUr3l71Rrz2J/IP0/DlpVC2pzMhNvlmmO+A1GLAJV2QTzht
         sSfRXZrVWq1BgZNzpFFZ2rMb4I+YIgtv30xovQWyKQIhYQ3RIGnSt7qsxrp5RwAq/ylv
         DYxW8Le150G/7Qbn7noHRARuXCXH6N4+rF4nWHUphZY1GxJ93JdAPqtTrmAW+dxXCUgd
         QTbA==
X-Forwarded-Encrypted: i=1; AHgh+RpIZ+6AjAEaboCJQvbYS5aPp1ggSlvcKnamxr9mboO/Cho6u1fCX0IkNoZqbOsl79C5bPDhq/azI5ZtozJDwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAm8b5i23A2KTog+gSEUOy42JHWAwIyrnFdrv//z9fZWoGc1gF
	dmCye7OPL9hFino7TaH8PWKCY3KfEJ9Eqec+MOX3JQwIbgoLg0ypsYj5mW0J3WiUF4LP0pu7rsj
	j8/spvHGUm0q1Gw==
X-Received: from wmoh4.prod.google.com ([2002:a05:600c:3144:b0:490:b2a6:e6f5])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e0d:b0:493:b499:3ef2 with SMTP id 5b1f17b1804b1-4953c299474mr25989985e9.37.1784113421736;
 Wed, 15 Jul 2026 04:03:41 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:03:21 +0000
In-Reply-To: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260715-spin-trylock-followup-v3-4-fc4d246f705d@google.com>
Subject: [PATCH v3 4/4] mm/page_alloc: remove a couple of VM_BUG_ON()st
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>, 
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>, 
	"=?utf-8?q?Michal_Koutn=C3=BD?=" <mkoutny@suse.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

VM_BUG_ON() is out of favour and on the way to removal, since I recently
touched alloc_pages_node_noprof() I am removing that invocation, and
also removing the __folio_alloc_node_noprof() one for consistency. If
this precondition is violated, the system will soon crash anyway.

Suggested-by: Zi Yan <ziy@nvidia.com>
Link: https://lore.kernel.org/all/7F866265-3F2E-4765-B9D4-9AB898A9C4AC@nvidia.com/
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp.h | 1 -
 mm/page_alloc.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 4d57e9c0bf204..872bc53f32ec8 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -255,7 +255,6 @@ static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
 static inline
 struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
 {
-	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
 	warn_if_node_offline(nid, gfp);
 
 	return __folio_alloc_noprof(gfp, order, nid, NULL);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 25a83a57aab66..4c6815f84adc6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5427,7 +5427,6 @@ struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 
-	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
 	warn_if_node_offline(nid, gfp_mask);
 
 	return __alloc_pages_noprof(gfp_mask, order, nid, NULL, ALLOC_DEFAULT);

-- 
2.54.0

