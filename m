Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067332D45E
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068752; cv=none; b=JeggIx/L9vi6x8Qufs3F3IY137PnW8OXNv9BTW5y4K8HCefYQKoS6H3V2ZHMo4DOJci7WISQ1Qtb428qAIIepbNuHZREci+Damz7VpbzhdrfQMZ3TSaAGPvwZwpEbm9YqXvhvA6eBK97Feo5Lb5gQ2etAxxTCoNDdtcoqXOAsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068752; c=relaxed/simple;
	bh=0n0xOTrnu/pUx1JeWT9IWRvkxGdppFFtm9ObE16iwcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx5j8tpnXbBBu2Q28/BYwCghsZmRUVD1/nRsNXjH4rUO3/0Im1DMhYnGXAedzPSpmsn3cmOJNbIXcCBu6DEcViTq1AWrJQcru0/MidN8nU0Fjf0DwXjy0cTFsqhuqdUEfBKe8e0QdH7Ie73OxGa8xrIMIrFVt/l8NZ5BfeMUn9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GCqhRVX7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0lI2TW/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GCqhRVX7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0lI2TW/"
Date: Thu, 22 Jan 2026 08:59:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769068748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZSlgHPlUt8ZbdPEXgaq8iH3gYM6F+jgddriVVcpP9M=;
	b=GCqhRVX75TvgW5UsGMvjVD0w730ylwgVyfHA/my4xaEmvj8j2iZK2QPru8hiGjIALmOnWP
	aSavGkWsKBiFE3ax+a1dcvaRXe5O7QN+yLGsX9ecJiEFJpKeQEvhY/7IQF2MNCu1dFLfDh
	muCtW0+1PK7t8a4fmsI8YmsdMJRi1z7zed1NFbVJyjdw1ujCWNc/yxx3jqxkiUgDHtrvCd
	W1ffkxZGaE5Ok1A0s1ephY5ZzlyWeNpIUJHeFulMLTqnbB+onVrOXLJBxIGUYndWiA91bg
	8b6fnTGBPT0tadbs8dU6QGIZt+L6+Q7jCQyFjI3ZmxJsfzGEb3VZo5+kYqL2ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769068748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZSlgHPlUt8ZbdPEXgaq8iH3gYM6F+jgddriVVcpP9M=;
	b=i0lI2TW/S6yXuSvuYhIcgQVVnQ9xxkHns1J3rHm3oRE+uQ3NDZuuQNT/SbjfYhF8LAFZ2o
	meDoA62Jwvz9TfAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v2] mm/mm_init: Don't call cond_resched() in
 deferred_init_memmap_chunk() if rcu_preempt_depth() set
Message-ID: <20260122075907.45LUOUoP@linutronix.de>
References: <20260122034017.505589-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260122034017.505589-1-longman@redhat.com>

On 2026-01-21 22:40:17 [-0500], Waiman Long wrote:
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2085,7 +2086,12 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>  
>  			spfn = chunk_end;
>  
> -			if (irqs_disabled())
> +			/*
> +			 * pgdat_resize_lock() only disables irqs in non-RT
> +			 * kernels but implies rcu_read_lock() in a PREEMPT_RT
> +			 * kernel.
> +			 */
> +			if (irqs_disabled() || rcu_preempt_depth())
>  				touch_nmi_watchdog();
>  			else
>  				cond_resched();

What about (as suggested in the previous mail)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index fc2a6f1e518f1..0b283fd48b282 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2059,7 +2059,7 @@ static unsigned long __init deferred_init_pages(struct zone *zone,
  */
 static unsigned long __init
 deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
-			   struct zone *zone)
+			   struct zone *zone, bool may_schedule)
 {
 	int nid = zone_to_nid(zone);
 	unsigned long nr_pages = 0;
@@ -2085,10 +2085,10 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 
 			spfn = chunk_end;
 
-			if (irqs_disabled())
-				touch_nmi_watchdog();
-			else
+			if (may_schedule)
 				cond_resched();
+			else
+				touch_nmi_watchdog();
 		}
 	}
 
@@ -2101,7 +2101,7 @@ deferred_init_memmap_job(unsigned long start_pfn, unsigned long end_pfn,
 {
 	struct zone *zone = arg;
 
-	deferred_init_memmap_chunk(start_pfn, end_pfn, zone);
+	deferred_init_memmap_chunk(start_pfn, end_pfn, zone, true);
 }
 
 static unsigned int __init
@@ -2216,7 +2216,7 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
 	for (spfn = first_deferred_pfn, epfn = SECTION_ALIGN_UP(spfn + 1);
 	     nr_pages < nr_pages_needed && spfn < zone_end_pfn(zone);
 	     spfn = epfn, epfn += PAGES_PER_SECTION) {
-		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone);
+		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone, false);
 	}
 
 	/*


Sebastian
