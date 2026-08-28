Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF135379960
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933383; cv=none; b=NG7StRvSsqm1VG23kFs+lm5zao9i1agUGsEYWeLr8DCow/Opi/zt7aqGlHuqRzmDUlUfjKv0LUkeMuBISeutpT41xVQ/yH3gtlc4tHEl7EjumRzZsPpj02k1dIcKEf05E2IV9QP2jKnKEdnbjEyHb26iuNMlekQzcPM7TF0ixiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933383; c=relaxed/simple;
	bh=EloB0katp8AvIPCuQbU503lG6mYrXa7AvQm9QMftF/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSXVjZMEVbDjFlI6UEHcGAqBE1LU8fQUpYSg+ng+FTPcv1++Zt7eZYc6z1PAS+c7CWcRDWqSZ8vtk/HTyY2yoteY4w8b9UUYGN6nDS/RsYGdbmgTdZ6U5/Ni0KWGjn1UMLnpv8O8gVGEXxpu5/FSq77eLuWn2gBnvYpSBH9Wyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=SUQWHdUr; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="SUQWHdUr"
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id D97DFC03F8;
	Fri, 28 Aug 2026 16:09:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 988AA2002E;
	Fri, 28 Aug 2026 16:09:20 +0000 (UTC)
Date: Fri, 28 Aug 2026 12:10:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Stevens <stevensd@google.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, Qi Zheng
 <qi.zheng@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Uladzislau Rezki <urezki@gmail.com>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R .
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 suleiman@google.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-rt-devel@lists.linux.dev, jstultz@google.com
Subject: Re: [RFC 00/10] Reclaimable kernel stacks
Message-ID: <20260828121010.47fa7713@gandalf.local.home>
In-Reply-To: <20260828144500.GW776954@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
	<20260828124758.GP687043@noisy.programming.kicks-ass.net>
	<20260828103328.633bbfbc@gandalf.local.home>
	<20260828143540.GV776954@noisy.programming.kicks-ass.net>
	<20260828144500.GW776954@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 48z84x6eyt4hnsuag3zedkjkfm3baagp
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 988AA2002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198HxFyXYgEZJwnf72i30sWt/lWTSWMtx0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=EloB0katp8AvIPCuQbU503lG6mYrXa7AvQm9QMftF/Q=; b=SUQWHdUrQzbFKVWGZ5xuskpOuRiSRULlG6ryJnBZGwRdZ5u67PBT5epIe0H7xg5SXNEX5TvwjgYAiKgBFn8ZVFZTo/UhBe7uCVkXSTXgl3qel4FHrisSpTHR0cXMEvTruijIo6t+0UY6KTNW3HgB/IH3lcx96mDtLDIYxSkl2wU=
X-HE-Tag: 1787933360-956987
X-HE-Meta: U2FsdGVkX1/U5Q0ostoyRiukFyNqFJhukFmTfCLv7rXt7diB6hyl/rZhUovQsUbfRuY/ruuw+CzkC8ZVCbdE5m17xKy+P2Hv3jyfNk0S4gBULlux/YQTMMl9V3ucR2xXxNGvpPJmpCP7P0aDUB8ibU6MmqlECvOPKid5V1OOzQt6NM3cjLlOo9ZuIQpgB8dSi6tyspx69xpNnpLwgNIG3TDSRJvGO7iERa9ou6pry9qFlRoyhFt1aUgs2Vz/JVAzyifFmbQZTDKS6nRAwD3NlsUyrhMO5du3Oou8k5oL+5IF7ADACZKUrPjYxLA7y874Dbta0aVQfHT5D1YLKlytYenuQaXYN9bClOSio+1VJY0xX4vNPnTY50qYg771Vo4/

On Fri, 28 Aug 2026 16:45:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> I realized I actually have a Java thing, the kids have Minecraft, so I
> booted that up and I found all of 108 threads. Which is still kinda
> insane, but nowhere near the 1000s per app as claimed.

Have you looked at how many threads Chome uses?

 $ ps -eLf|grep chrome | wc -l
 930

Of course I probably have 900 tabs open :-p

-- Steve
