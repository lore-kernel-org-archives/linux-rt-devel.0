Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB36469842
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189167; cv=none; b=Af5WiQJ5vM3QIBxM4dlkvpd+pVUFQqEUgPXaE45OvUdzkE8GqKhmt0z78eZtcWwcof5QDsuqCTXDAhMDKeCwJtclAJ4PS7faJZXHd4+m/1YVmCeTKDoznd4wJ72Ak/lSL8EJm9lJ/egP1Yq9q1z7cYItxps9iPnok/yIrJwDjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189167; c=relaxed/simple;
	bh=BnVjcpzY05zXXIl2q4HzXywiQBBnVViBbAvYTujqAlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/LfWDvG7rhG/N8/NETs+L6ul3bFxLB9sj7TlIbfvwmyRVvZ9NvG60ETDzs39V1nh6fzcbFUps0kwmO5/b2vcFmSlP6q+42Ra/EOE2smXK0ErY7bRco2GZErXgIADob9/xNOysGszMB1JaJ5kIWYinDOTj/YR9iQGG0IoTmoJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=cImwxCY5; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="cImwxCY5"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 72460A3176;
	Mon, 31 Aug 2026 15:12:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 17D2620029;
	Mon, 31 Aug 2026 15:12:24 +0000 (UTC)
Date: Mon, 31 Aug 2026 11:13:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, David Stevens
 <stevensd@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Chinner
 <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Uladzislau
 Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook
 <kees@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 suleiman@google.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Message-ID: <20260831111320.7b6b3946@gandalf.local.home>
In-Reply-To: <20260831065509.qqEtERDB@linutronix.de>
References: <20260827232948.2520558-1-stevensd@google.com>
	<20260827232948.2520558-7-stevensd@google.com>
	<20260828133620._x2XfJR_@linutronix.de>
	<20260828135947.GU776954@noisy.programming.kicks-ass.net>
	<20260828151018.HnR9xV1N@linutronix.de>
	<20260828150836.2d5b378c@gandalf.local.home>
	<20260828151313.5c4a5e4b@gandalf.local.home>
	<20260828151747.20035d50@gandalf.local.home>
	<20260831065509.qqEtERDB@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 17D2620029
X-Stat-Signature: 9sd7qcroq64gea6uibr6ape7cx7e1ykm
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/3KtEVjKaohpMEOxH4xzYg00zpuzVZqIw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=IKf/qv+ZKDMiRuq6ap8IBmRH94f4tOFqUTBggMx1BmU=; b=cImwxCY5M6/MZq1vXrGpwXyJIW4H4hu5sS1KO7PpnpoXteZNbNQ+GhZzlHqKlL3ZkFB0HN34EWkqTzLeQyS8IcFKie7OGgIlnJDjKa6hVhBcyvMHmYDM/yhwmGkc1A/6BHmeSAl3QTXL0In4xCov5c0vPfeze8DOuvivudM+e4o=
X-HE-Tag: 1788189144-66867
X-HE-Meta: U2FsdGVkX18dzhGCsgKCVwcrIISXc5+c8eAfc+lay5xArphhXwOHYX/nvWZLcCNFYp/sd112suTMB0NzpOGtFdRY72fbzgE39wDPlKiV4JS9YOYXjTah/tBYpd2756XDxPPscNMuqeK262zY2EEZNuLwXIXN/boqjUHRkq/XHc8VDiMguYSMX3Fw9u9/Ec2SavB2O6BTLoVKPnTjGCPjSORO1SLgGh0MREZxm6i8RaGqjgOEjD6WMtZo4umY6LccK88OvdVUTL+WTfjTOF+AZaafG8EqAzLRlgRtocOn6VnjyRlU2JmSCo78sE9rgM2F

On Mon, 31 Aug 2026 08:55:09 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Does this stack tracer distinguish between the kernel-stack and
> IRQ-stack?

It should only look at kernel-stack and not the irq stack. This stack trace
may have triggered when the interrupt put back the kernel stack, as it is
in the irqentry_exit code and about to do a schedule. The code has:

kernel/trace/trace_stack.c:

	/* we do not handle interrupt stacks yet */
	if (!object_is_on_stack(stack))
		return;

Which returns if the object is on the kernel-stack, and here "stack" is the
parameter passed into this function.

> I would expect asm_sysvec_apic_timer_interrupt() on the
> IRQ-stack and not adding weight to the kernel stack.

Right. But I believe this is where it switched back to the kernel-stack.

> Given how close this is to 8192, I don't think two stack pages will
> happen soon.

Agreed :-(

-- Steve
