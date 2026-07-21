Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863F4D9905
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647280; cv=none; b=Mfo085Lr99siWymOzqkjlWBgUg33aehVv+LsZ8S3ijQCvRiN0fPgXbP/Bg7oA31HZg/F8Z4kb/6YmjaBWrp5UG0swEhi45DApduptLkU6vSHzX6L0h8YqRm8bLvwMoxPXPLyW1C10//6KASJ7TXcOs4DIf392Y5QUkq0Qt2wDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647280; c=relaxed/simple;
	bh=Rn9T1Ij/p7WDJ7MNxLok4k8E+5Zh/8lMCXsIlnSdfUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFalQKYM8ulWeEZoYxBFhxwiYcOlmAsEGxaNUaZEpXxx/yompqu8oRjEEki+Wfy6jAwlHlfti5QnTltYnkfo6ZobXtOj3gUrrPcXztC01l8hLugV9FGwAhfzJGHrdZNqKA+JMKntOmZLOKZyEfQG0bzOFBBpEG64M72MhWM0KZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7QJnGP6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1dJ3HDFS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7QJnGP6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1dJ3HDFS"
Date: Tue, 21 Jul 2026 17:21:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784647276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8Bb8jYj0RhS9Rf+pd9pfpTHkr9/nkvB/xMMYo+RrpQ=;
	b=z7QJnGP6pxAWrNGwLtFJCAyJrlfcD4b71sEcJi7hbBfqvW2JVFnXuKYJxQAMGUow1n0M9y
	LGzjHllFLXlpm/tdWynU0AX8gwL9yYJZObWumN7DzDiRPcRqulFQlc2fF71b7TR1eduHXg
	eIzyul9BcZsV92rVy3RXJtW3dMse+VF38loDiJcsPhcSqreJQtih+J/DwKQQu449RSNtVy
	CVaRXpSlWB1hZYXUB/Xt7D5GvPEBjTMFmdzjsy+7a3Q84ss5DHaIUcANvnSp0b8aLqM1tJ
	jwnSonCWl9NmbUrLh+1rAYNiOZDKf10pm7LOVQa7UlsfTsO9ecRnW+Qt15zyOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784647276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8Bb8jYj0RhS9Rf+pd9pfpTHkr9/nkvB/xMMYo+RrpQ=;
	b=1dJ3HDFS7rSj5wJnfjUHsA2BHtsK4tm2Mq8g3/3eGFaG0uGISgZvLw8IHrwsRVrtPwHsUw
	rX8uKNLu8d6xshAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <20260721152114.wTED4bR5@linutronix.de>
References: <20260716195716.256025-1-darwi@linutronix.de>
 <20260716195716.256025-2-darwi@linutronix.de>
 <20260721130248.ndwsFtHE@linutronix.de>
 <874ihs5s4d.fsf@jogness.linutronix.de>
 <20260721143606.NqT15H0p@linutronix.de>
 <20260721104806.64afcd8f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721104806.64afcd8f@gandalf.local.home>

On 2026-07-21 10:48:06 [-0400], Steven Rostedt wrote:
> On Tue, 21 Jul 2026 16:36:06 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > > Unfortunately, debugfs is needed to configure the fair deadline server:
> > > 
> > >     /sys/kernel/debug/sched/fair_server/cpu*/runtime  
> > 
> > So drop the reference to it. It is not "bad" to have it enabled. It is
> 
> I believe that some distros feel that it is bad to enable because there's
> no real auditing of its interface. Although, it is now only accessible by
> root.

Yeah. Either way, there shouldn't be anything real-time specific that
requires the user have it enabled or disabled.

> -- Steve

Sebastian
