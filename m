Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B0522F;
	Tue, 26 Nov 2024 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618172; cv=none; b=YXDVb/FlIo1p+z5AWf3/RUQUkCoW7cn5nO8QL4WgKXoWn0swayEh/JT+5hnlKXQ2+26soSecmaLt/Gdr0E3tva9dM+9zfyrxRJQPGzP39v3+oe2UnQ5KDAUrAu8KyTW4EkSDYgOo9Twr4i8ZLtIGe0s3FcMQkR7LRh6iAbTPRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618172; c=relaxed/simple;
	bh=7Q/SpZuROhuUTym2Z4c4qdvRZ8pFSXvgBLH1/0WEVek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyZchd+UcfFiW0oX/yWFk2uAtM7bjMTYpm4AsyypNK6ob2gdv03gLXJ+r8+nI5KSncZkAAljLusvYIInhR5SJjYRZY2MuhUv+jBg1vG6cSVTflI7o5GxHAa7ID6G8wVWMTdXfq4Cbe8aJdhMcvdHv3C39H7phmghWfw6EmtIgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40926C4CECF;
	Tue, 26 Nov 2024 10:49:29 +0000 (UTC)
Date: Tue, 26 Nov 2024 10:49:26 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
Cc: Alessandro Carminati <acarmina@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
Message-ID: <Z0WntpeJ54-ZdBrf@arm.com>
References: <20241120102325.3538-1-acarmina@redhat.com>
 <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home>
 <20241120164043.T1JuBALe@linutronix.de>
 <CAGegRW4B5PO0HgY1TvsV_R0hPSa5vHk7f=fy0skMpcy+BT399Q@mail.gmail.com>
 <20241121170356.eC7f3-1v@linutronix.de>
 <CAGegRW41HOdG+vEA6vwmC3WWJkRgMksasvoRWdwRzAE7mFbHEA@mail.gmail.com>
 <20241126090438-dfd305cb-3736-4d31-a690-4d00208783d5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126090438-dfd305cb-3736-4d31-a690-4d00208783d5@linutronix.de>

On Tue, Nov 26, 2024 at 09:11:31AM +0100, Thomas Weissschuh wrote:
> On Fri, Nov 22, 2024 at 11:48:04AM +0100, Alessandro Carminati wrote:
> > On Thu, Nov 21, 2024 at 6:04 PM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > > On 2024-11-21 17:50:06 [+0100], Alessandro Carminati wrote:
> > > > On Wed, Nov 20, 2024 at 5:40 PM Sebastian Andrzej Siewior
> > > > <bigeasy@linutronix.de> wrote:
> > > > >
> > > > > On 2024-11-20 10:26:02 [-0500], Steven Rostedt wrote:
> > > > > > The "%pK" dereferences a pointer and there's some SELinux hooks attached to
> > > > > > that code. The problem is that the SELinux hooks take spinlocks. This would
> > > > > > not have been an issue if it wasn't for that "%pK" in the format.
> > > > >
> > > > > That is missing check and I think Thomas Weissschuh wanted to add it. So
> > > > > we don't call into selinux.
> > > >
> > > > Your comment confuses me a bit, as I'm unsure what Thomas is actually
> > > > working on.
> > > > Am I correct in assuming he's addressing a fix in lib/vsprintf.c to ensure
> > > > that sleeping functions aren't called, allowing these functions to work in
> > > > any context?
> > >
> > > restricted_pointer() has a check for in_hardirq() among others. This
> > > needs an additional PREEMPT_RT check.
> > > I would be actual in favour to get rid of case 1 for kptr_restrict and
> > > have either 0 or 2.
> > >
> > > > However, his mention of "This fix for kmemleak is still needed as the
> > > > pointers in the kmemleak report are useful" adds to my confusion.
> > > > Meanwhile, Steven suggests reworking SELinux to resolve the issue.
> > > > Could you clarify what you mean by "So we don't call into selinux"?
> > >
> > > This getting out of hand. By adding the PREEMPT_RT check to
> > > restricted_pointer() we don't call in selinux so the problem is gone.
> > 
> > I am really glad that now we have a clear solution, however practically
> > speaking is Thomas working on such a patch or is he working on something
> > related that does not fully solve the problem?
> 
> I am working on a change to lib/vsprintf.c. Something like the
> following:
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index c5e2ec9303c5..54ad175a22bd 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -870,6 +870,9 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
>                         return error_string(buf, end, "pK-error", spec);
>                 }
> 
> +               if (IS_ENABLED(CONFIG_PREEMPT_RT) && ...)
> +                       return error_string(buf, end, "pK-error", spec);
> +
>                 /*
>                  * Only print the real pointer value if the current
>                  * process has CAP_SYSLOG and is running with the
> 
> 
> Hoping to replace the ... with something that can detect actual
> problematic situations at runtime.
> I'm fairly new to PREEMPT_RT so need to do some digging.
> 
> > Even if he is working on a partial solution, I am happy to coordinate
> > off-list working on his own private branch
> > (or else I would just give up and review the Thomas' patchset when it is
> > out...)
> 
> Given that there is no direct interaction between your kmemleak patches
> and the vsprintf ones I don't think coordination is necessary.
> I'll Cc you for review.
> 
> Please do go ahead with your kmemleak patches.

If the above fixes the kmemleak warnings by not triggering a call into
SELinux, I'd rather not change kmemleak. I don't know how important it
is to run kmemleak with kptr_restrict=1 and get meaningful pointers.

-- 
Catalin
