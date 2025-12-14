Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07DF155A5D
	for <linux-rt-devel@lists.linux.dev>; Sun, 14 Dec 2025 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765748307; cv=none; b=VmwJnoixjZYxCdUa88LrD+W6dAuNQMafyqzTjgDU2P5YwRX63eZOtdi7twDefzxQtUmrnQgzEEsvIBeVUERyi8LYS8CtAM36XKz4JvhJ/orLWuYNQH2YvP+CV852qv2S2bjfxfNxU12+PFyk+Q6CDb/4YMZUXfhprBCnTzhjc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765748307; c=relaxed/simple;
	bh=NYLyzvVuuleE9gG/8P+CRXYvr4qbLrmQTlA3ApljXEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND6AmTfJRO4d/IqxLw1A5NvhNYt2AcvDGJJOB6At4Q2FAOzRViiPRQCXFAA1r5M0afPOSNxrONk754Nf+kurZfDWbhWobZty7nKCLpkP/jIcWcZzbizx7JM8aHDsgh0ndx+y1vOl/X4Bq8iHH6v4Bmp6ao60qnb6vjdr5/0yJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id E892572C8CC;
	Mon, 15 Dec 2025 00:38:16 +0300 (MSK)
Received: from altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id D194B36D00D3;
	Mon, 15 Dec 2025 00:38:16 +0300 (MSK)
Date: Mon, 15 Dec 2025 00:38:16 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: Ranganath V N <vnranganath.20@gmail.com>, 
	linux-rt-devel@lists.linux.dev, edumazet@google.com, davem@davemloft.net, 
	david.hunter.linux@gmail.com, horms@kernel.org, jiri@resnulli.us, khalid@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH net v4 2/2] net: sched: act_ife: initialize struct tc_ife
 to fix KMSAN kernel-infoleak
Message-ID: <3kwhg36anlckq57bez25aimvyj@altlinux.org>
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
 <20251109091336.9277-3-vnranganath.20@gmail.com>
 <tnqp5igbbqyl6emzqnei2o4kuz@altlinux.org>
 <CAM0EoMmnDe+Re5P0YPiRTJ=N+4omhtv=r3i5iicav8R7hg6TTQ@mail.gmail.com>
 <CAM0EoMneOSX=AMe53hQibY=O6n=KYnudAWfVtUdOf8qc_Bmw+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMneOSX=AMe53hQibY=O6n=KYnudAWfVtUdOf8qc_Bmw+Q@mail.gmail.com>

Jamal, and linux-rt-devel,

On Fri, Dec 12, 2025 at 11:29:24AM -0500, Jamal Hadi Salim wrote:
> On Fri, Dec 12, 2025 at 11:26 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > On Thu, Dec 11, 2025 at 7:54 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > >
> > > On Sun, Nov 09, 2025 at 02:43:36PM +0530, Ranganath V N wrote:
> > > > Fix a KMSAN kernel-infoleak detected  by the syzbot .
> > > >
> > > > [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> > > >
> > > > In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> > > > designatied initializer. While the padding bytes are reamined
> > > > uninitialized. nla_put() copies the entire structure into a
> > > > netlink message, these uninitialized bytes leaked to userspace.
> > > >
> > > > Initialize the structure with memset before assigning its fields
> > > > to ensure all members and padding are cleared prior to beign copied.
> > > >
> > > > This change silences the KMSAN report and prevents potential information
> > > > leaks from the kernel memory.
> > > >
> > > > This fix has been tested and validated by syzbot. This patch closes the
> > > > bug reported at the following syzkaller link and ensures no infoleak.
> > > >
> > > > Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
> > > > Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > > > Fixes: ef6980b6becb ("introduce IFE action")
> > > > Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> > > > ---
> > > >  net/sched/act_ife.c | 12 +++++++-----
> > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> > > > index 107c6d83dc5c..7c6975632fc2 100644
> > > > --- a/net/sched/act_ife.c
> > > > +++ b/net/sched/act_ife.c
> > > > @@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
> > > >       unsigned char *b = skb_tail_pointer(skb);
> > > >       struct tcf_ife_info *ife = to_ife(a);
> > > >       struct tcf_ife_params *p;
> > > > -     struct tc_ife opt = {
> > > > -             .index = ife->tcf_index,
> > > > -             .refcnt = refcount_read(&ife->tcf_refcnt) - ref,
> > > > -             .bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
> > > > -     };
> > > > +     struct tc_ife opt;
> > > >       struct tcf_t t;
> > > >
> > > > +     memset(&opt, 0, sizeof(opt));
> > > > +
> > > > +     opt.index = ife->tcf_index,
> > > > +     opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
> > > > +     opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
> > >
> > > Are you sure this is correct to delimit with commas instead of
> > > semicolons?
> > >
> > > This already causes build failures of 5.10.247-rt141 kernel, because
> > > their spin_lock_bh unrolls into do { .. } while (0):
> > >
> >
> > Do you have access to this?
> > commit 205305c028ad986d0649b8b100bab6032dcd1bb5
> > Author: Chen Ni <nichen@iscas.ac.cn>
> > Date:   Wed Nov 12 15:27:09 2025 +0800
> >
> >     net/sched: act_ife: convert comma to semicolon
> >
> 
> Sigh. I see the problem: that patch did not have a Fixes tag;
> otherwise, it would have been backported.

Thanks! I will pick this for the local builds. But, perhaps, someone
should send it to stable@kernel.org to fix the older -rt kernels too.

Thanks,

> 
> cheers,
> jamal
