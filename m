Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47628FF
	for <linux-rt-devel@lists.linux.dev>; Tue, 26 Nov 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608696; cv=none; b=Ti5ggDk0I+9Jmuvi6wByKLatvc3aO2uyrl0NEaSkjYyDYInJNy0kZujc2vHbpNtoH//lWp5Xh1lkeXcPdF4hYDmbaVtX2p9zleBnck0BIO/lXpHcSOg10Dlcmy3fewoF3kbN8tS1ZuEyGbX2J7oxsabX8Zd4tHLg5Yb3K7/4JEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608696; c=relaxed/simple;
	bh=ZQ5IeOd/v+2t/sSKX+OqFtyTlU/lckQh2YHMfSeidGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU5liiW6pRmPEpDkr9kRhR7wEKtx7CuWxXqRygN9vuVsk6Ksc4pgmyGvwrSzvYlbjHiARMswb3m1DDBsRvpcyiAkJ6d8UgDIpeV23ShQ3Y7+7g0+S7sRgvJukELAMLWaYGExfkSirrHgv4tOYJdt9novYoux9TvGxpmr9ixDJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iAKqnXTQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4+BUyeva; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iAKqnXTQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4+BUyeva"
Date: Tue, 26 Nov 2024 09:11:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732608692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GpAmMAZCucWPeDiq8mLR20xNnMwG7bVAX/MvW6+Uuw=;
	b=iAKqnXTQajhI4kjjTB/anN12F6qChlZ0p9i+DtgtsQgzx6tlVkkuRDYjg6GeqpHnbtqEP9
	IeJ4bS7T7MIalLBXP+cinMznxIqjBwP574gySERomDpRCI3VCZs4H2x4GcrVk6OriPKgSy
	k0IttScrm51JFPmD3LVdT9M/4THKGKeXmX2kt/IW8zDBKroqr3cKGOhx5Ag8rvzB4tLm/O
	EUQepAfChebPSO1GV3csc5PfpyF5jKHryCDvvk3oMhGqGkzQIQY8mP8J/rcKK2N1vnTGZX
	saL2SNzcDzFOiquuFocu6logxEl2L1zj2KjNuI7VJK6NORznFX8Zi9y23f9+VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732608692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GpAmMAZCucWPeDiq8mLR20xNnMwG7bVAX/MvW6+Uuw=;
	b=4+BUyevajUdVU0h0msD6cmfDlTg3d4v7zmmLwmGjqSuXWQgeIMgJAhY/hYzkKzilhtRjec
	a6cxRnX9+HB2P6AQ==
From: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
Message-ID: <20241126090438-dfd305cb-3736-4d31-a690-4d00208783d5@linutronix.de>
References: <20241120102325.3538-1-acarmina@redhat.com>
 <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home>
 <20241120164043.T1JuBALe@linutronix.de>
 <CAGegRW4B5PO0HgY1TvsV_R0hPSa5vHk7f=fy0skMpcy+BT399Q@mail.gmail.com>
 <20241121170356.eC7f3-1v@linutronix.de>
 <CAGegRW41HOdG+vEA6vwmC3WWJkRgMksasvoRWdwRzAE7mFbHEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGegRW41HOdG+vEA6vwmC3WWJkRgMksasvoRWdwRzAE7mFbHEA@mail.gmail.com>

Hi Alessandro,

On Fri, Nov 22, 2024 at 11:48:04AM +0100, Alessandro Carminati wrote:
> On Thu, Nov 21, 2024 at 6:04 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > On 2024-11-21 17:50:06 [+0100], Alessandro Carminati wrote:
> > > On Wed, Nov 20, 2024 at 5:40 PM Sebastian Andrzej Siewior
> > > <bigeasy@linutronix.de> wrote:
> > > >
> > > > On 2024-11-20 10:26:02 [-0500], Steven Rostedt wrote:
> > > > > The "%pK" dereferences a pointer and there's some SELinux hooks attached to
> > > > > that code. The problem is that the SELinux hooks take spinlocks. This would
> > > > > not have been an issue if it wasn't for that "%pK" in the format.
> > > >
> > > > That is missing check and I think Thomas Weissschuh wanted to add it. So
> > > > we don't call into selinux.
> > >
> > > Your comment confuses me a bit, as I'm unsure what Thomas is actually
> > > working on.
> > > Am I correct in assuming he's addressing a fix in lib/vsprintf.c to ensure
> > > that sleeping functions aren't called, allowing these functions to work in
> > > any context?
> >
> > restricted_pointer() has a check for in_hardirq() among others. This
> > needs an additional PREEMPT_RT check.
> > I would be actual in favour to get rid of case 1 for kptr_restrict and
> > have either 0 or 2.
> >
> > > However, his mention of "This fix for kmemleak is still needed as the
> > > pointers in the kmemleak report are useful" adds to my confusion.
> > > Meanwhile, Steven suggests reworking SELinux to resolve the issue.
> > > Could you clarify what you mean by "So we don't call into selinux"?
> >
> > This getting out of hand. By adding the PREEMPT_RT check to
> > restricted_pointer() we don't call in selinux so the problem is gone.
> 
> I am really glad that now we have a clear solution, however practically
> speaking is Thomas working on such a patch or is he working on something
> related that does not fully solve the problem?

I am working on a change to lib/vsprintf.c. Something like the
following:

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c5e2ec9303c5..54ad175a22bd 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -870,6 +870,9 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
                        return error_string(buf, end, "pK-error", spec);
                }

+               if (IS_ENABLED(CONFIG_PREEMPT_RT) && ...)
+                       return error_string(buf, end, "pK-error", spec);
+
                /*
                 * Only print the real pointer value if the current
                 * process has CAP_SYSLOG and is running with the


Hoping to replace the ... with something that can detect actual
problematic situations at runtime.
I'm fairly new to PREEMPT_RT so need to do some digging.

> Even if he is working on a partial solution, I am happy to coordinate
> off-list working on his own private branch
> (or else I would just give up and review the Thomas' patchset when it is
> out...)

Given that there is no direct interaction between your kmemleak patches
and the vsprintf ones I don't think coordination is necessary.
I'll Cc you for review.

Please do go ahead with your kmemleak patches.

> > kmemleak is not the only problem. printk(), as another of vspritf pointer
> > code user, can be called from any place and would also trigger a
> > warning here.
> > As far as "kmemleak need to be usefull" goes: With kptr_restrict == 0
> > then with or without pointer hashing they will be useful. If we need to
> > go via selinux then it ends as a hint.


Thomas
