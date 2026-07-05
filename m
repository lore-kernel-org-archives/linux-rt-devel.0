Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125251DB356;
	Sun,  5 Jul 2026 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783282717; cv=none; b=Ib89vkF7bFe7q9GfJ6oFkb8Fn+0qwVv91dBxrXpTuTyXfSXOj9L3YxX+AIegeGjcK1tGQ1QB6+v4lCrxtWvvilo6n//v8szYRr9tqZygrqKFqSfDxjcn+cTGNWClPEElhTQkETmf7PtEjHlHmewgcTfcnyaidiYL8geknJueI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783282717; c=relaxed/simple;
	bh=1DRnmzORz54UtZwUkA08qDgwarIfJ6CvlYe98LH7/co=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RZ1oLG7cqNdRo846V9fzNzyr+dV4fxCNPj3Y6OPZ4/CLYIn39ZNLadfLqQe2Xl+Fyo1stu15WtLXl8qALLkn8wlmSH6+8be2rhOEvxVbKFwo9kINGwxzdD3hiGnLc4/Bm6r6Y4/ONEQ5E2NPs53XKt2YutjJHn4h+WnA89PKcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lgO2qUEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lgO2qUEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEFB1F000E9;
	Sun,  5 Jul 2026 20:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783282715;
	bh=P4FRfs+r9UOQm82JdSaXJYhWrxqzlI7PQs2TLJymxfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lgO2qUEInva3L149MUs7ObNlZY1uRIObRaXzfLxsEf23hMT20ldiM7NdjGJhPE4+L
	 zN0VfkpLZmnQpf1YdOw7Jxg5kD0ebZPEOXui0NC9xczxxlD/O4X0lQxj6UfX4Gb871
	 Zl5FEXw178ilqC7+Kabr5BKYisaBSpWeWR5XDSxM=
Date: Sun, 5 Jul 2026 13:18:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Rodolfo
 Giometti <giometti@enneenne.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Eliav Farber <farbere@amazon.com>, Michael
 Byczkowski <by@by-online.de>, Ingo Molnar <mingo@kernel.org>, David Laight
 <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v7 1/1] pps: pps-gpio: split IRQ handler into hardirq
 timestamper + threaded handler
Message-Id: <20260705131834.777ac0d0ac5137a27a1ec0b1@linux-foundation.org>
In-Reply-To: <akm0-V6VTVp7-yQi@mozart.vkv.me>
References: <cover.1780359378.git.calvin@wbinvd.org>
	<2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org>
	<20260704180611.8898a9e290016d2dda70f6ae@linux-foundation.org>
	<akm0-V6VTVp7-yQi@mozart.vkv.me>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jul 2026 18:35:53 -0700 Calvin Owens <calvin@wbinvd.org> wrote:

> On Saturday 07/04 at 18:06 -0700, Andrew Morton wrote:
> > Thanks, I'll add this to mm.git's mm-nonmm-unstable branch.  This means
> > it will get linux-next exposure immediately.
> > 
> > All being well, I'll later move this into the non-rebasing
> > mm-nonmm-stable branch with the intent to upstream it in the next merge
> > window.
> > 
> > Sashiko AI review might have found some issues, one of them
> > pre-existing.  Please check it out:
> > 
> > 	https://sashiko.dev/#/patchset/2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org
> 
> Hi Andrew,
> 
> I've sent three patches which address all the sashiko issues:
> 
>     https://lore.kernel.org/lkml/c5c97c3b3c9d66010382094fd538e59a38f4aacf.1781289959.git.calvin@wbinvd.org/
>     https://lore.kernel.org/lkml/672778c177ac9b6fdcb445e35c97ac4ca7d1149f.1780506611.git.calvin@wbinvd.org/

OK, thanks, grabbed.

>     https://lore.kernel.org/lkml/7a71b8e74bce9582d3286d31e6c85ac77465e421.1780108620.git.calvin@wbinvd.org/
> 
> I can resend those as a series if it saves any time, let me know (the
> last one has a trivial conflict with the patch you just merged).

The last patch ("pps: pps-gpio: split IRQ handler into hardirq
timestamper + threaded handler") appears to be altering code which
isn't there any more.  So yes please, resend.  Please cc myself.
