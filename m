Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936AB35C69E
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927577; cv=none; b=KGHjs7owhdRde6HScWBJ/FqKewwPYJfrBa6QWa8xcc7q8PxroqcEHDa70BujkhutE/9lKp/Y0N+tAmTsVEAsInkeU0Jl0uaDwy+EXYxF8To0LRr6/FH599WPuvkpLHGz/kLV1kxr9bkegvO/2tIQcu+QG7x/X4Jr7j4NGKGzIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927577; c=relaxed/simple;
	bh=gSswE62nZO1pM/YMe3vEMOmmy6ONtBAf7AP4Kv4dNqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8brchR7kZD46w7fnL7JdUTMntPgeYKD2p66xK9dvYfHb+eK1lDLtmoqTq9IPGJJrPYM/6uNywhEE0ybnWhZ+LIY/iBLesEx9VzDiNb9xAli9sLWcv628z8IdbSsvSR57+LUsD3tWRYWPYYeOjLpmIHw87v6YFQ66AYxlIMVB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=PTsDfFpy; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="PTsDfFpy"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 56281A03CB;
	Fri, 28 Aug 2026 14:32:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 68DD520027;
	Fri, 28 Aug 2026 14:32:38 +0000 (UTC)
Date: Fri, 28 Aug 2026 10:33:28 -0400
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
Message-ID: <20260828103328.633bbfbc@gandalf.local.home>
In-Reply-To: <20260828124758.GP687043@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
	<20260828124758.GP687043@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 68DD520027
X-Stat-Signature: ztkfmnrpgu49shqhx5dux69fx5guyh4n
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/SjYl3uwJx4/ioiGGgwrjcuLujqecRKpg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=txgaP3eXPwGHZiNk+kzD9nMiqpi6Z8kpuswwMKDKk10=; b=PTsDfFpy3Vn67qp+64dLKVjQMOectY5i18n4Kp3f0JbzDuDbg7QuhtcfWz3fQ0TXyhJjaIW8ExLbYtONSHMQyC1lyZxg1V6i+rr5HmbeaXTfnqg0mSKpLe1M7Xz4Ctw9aeW54P5Vi/KVRNyogahr68RbAAuK75JA7ttYZ7ZvTJg=
X-HE-Tag: 1787927558-448627
X-HE-Meta: U2FsdGVkX1/ynCiK2eODLPrYZ9tK1G7fze2omD18GRMu+p//Za8+4H8RGGJDHLXLBjpOVe3LkBV8eMOFg5z3gwtX0OJ59kPUZ1lXGuPE1Jngey2WvrHtD2Ios5dJmmCOW6/JzjEJjZR90rWu8s+8+rGI/f3PjKGR+amq7feErZbTZBZRK1a0gZQoVjeHxPsRe1WHdO9gAWNFsSVvOHPGAZ3BLjjMhQSGqs6mMT5JrzNV9F/rZcZ43kHOPupCbE6Oeze20thPJ6wIJ05cvfQ3P1S19nukkkme0//ZjrjG06nJBIEqqfBqKclCyd8maOH2IMWUNDJmDCxPXN7KuEq4eel3RCvHJX/rMXNPrmNloIAPLi5whsjRBjeIKs43ysEB

On Fri, 28 Aug 2026 14:47:58 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > On Android, system processes typically have 2000-3000 threads. App
> > processes add 1000s more threads on top of this.  
> 
> WTF ?!? Why does that all spawn *that* many threads? Perhaps work on
> reducing that some?

I guess you never ran Java ;-)

-- Steve
