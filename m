Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5D220F3B
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 May 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842985; cv=none; b=Ex2fi8D/9swZWe+4vRAjDBHo0rukcZcoXbrNEI9TUbFHTQ5zLP9AM0sT2AUadIFIqQ5Y/woIAUs1Ico1jCmX5mp8WFcFBd8+yYvkZXEufj07IG/BVgzcX7KFC+D4XVbYtxllnabzOwoYMCYTrKWs9oaJKL8CV+l/W7FbEKM0aI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842985; c=relaxed/simple;
	bh=LsOki43xFaELozXRuivgBnjlnGJb6BPx2a7ZMmnjVCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx60excGdtOMWTbROYfdaSzbOdfy2AxttqEO/18b3R2XRyWOEEv3f8jcZVmkQM4AusIx3VoDyzSQK8rEbLlghi3xnhk4fml32DR3EWoFj9EGVfqhh27KlLv8sYfYKhNKd+ZSOr7nUSmNilCp5Gg9CziAahHP4S6DGzzMQA9awug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=YNi7lvdi; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=CsoBoIBo; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="YNi7lvdi";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="CsoBoIBo"
Received: by mail.netfilter.org (Postfix, from userid 109)
	id A05F6606CA; Wed, 21 May 2025 17:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1747842981;
	bh=tSDwKxtYTDRSvs9khn3OIeuW0LJnR39TXkhFaSelHRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNi7lvdiCWI77kHkm4BjarWchP3IdumgvYRkVixZkZ+pQvMQirLw7+Bq9qwsOzqHE
	 xLlhn2HdRZwcq8TWPh0FukDGtTQKMgyaeNBZ8vjpYstZb7m6kkvbhwsGKgkI6b4iwI
	 T6ZUIeZPj2P722ptRzOhPOGo1qyJGwqkEqa7G5xAMoiVDgzlTdZzj7FPZIN7JVqsbb
	 4i2locyPLztkAZk3hcq0U+40rdZgNP7PeuWwEfwXQ0XrY6sefVbLY1kUi7QhiU0INH
	 NqqQ+8lyKzu5sCP6VD4+LIyHgej6dWd7FUYfVEsBS/bCeqtKl3Or+PdOefSIesijI3
	 OC4p3ODd/jPKg==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 1D5B1602EA;
	Wed, 21 May 2025 17:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1747842979;
	bh=tSDwKxtYTDRSvs9khn3OIeuW0LJnR39TXkhFaSelHRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsoBoIBoKbxkvw+MB32tsclp+Wo4e/HA5sZiCLLzJtUxPPJnVSt/toO/U5cZMkE51
	 ODHr6JBNPlTsEBFonP1fTanbqQY6/2umR2wckDRFVZahb1EovAsN3bhmgDlmWNI6sB
	 R5FJoAbNOWCGli7G8onYwiWPjc0cD8NpWPdMIRWB2Lg/jqTtkW/eJlKhq87ORV5N+W
	 bfmeugMLoK5pnYTVoxFB1Qcq65cNS5+IPesVJzIPt84WVR4Q//lvU+R5XNQZ4yLurH
	 DImF8q9WscMxFevbGPfZtJIWNNT84ZkOKHTPHlkGDme5KK1eOqqvgHa7eX/nH4dlYj
	 63iK59y1l1gyw==
Date: Wed, 21 May 2025 17:56:16 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-rt-devel@lists.linux.dev,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH nf-next v1 1/3] netfilter: nf_dup{4, 6}: Move duplication
 check to task_struct
Message-ID: <aC33oGX0QJWVkLRM@calendula>
References: <20250512102846.234111-1-bigeasy@linutronix.de>
 <20250512102846.234111-2-bigeasy@linutronix.de>
 <aC3iO9FJo1FvdloW@calendula>
 <20250521144043.GFZkHbrX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250521144043.GFZkHbrX@linutronix.de>

On Wed, May 21, 2025 at 04:40:43PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-05-21 16:24:59 [+0200], Pablo Neira Ayuso wrote:
> > Hi Sebastian,
> Hi Pablo,
> 
> > On Mon, May 12, 2025 at 12:28:44PM +0200, Sebastian Andrzej Siewior wrote:
> > [...]
> > > diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
> > > index 0c39c77fe8a8a..b903c62c00c9e 100644
> > > --- a/net/ipv6/netfilter/nf_dup_ipv6.c
> > > +++ b/net/ipv6/netfilter/nf_dup_ipv6.c
> > > @@ -48,7 +48,7 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
> > >  		 const struct in6_addr *gw, int oif)
> > >  {
> > >  	local_bh_disable();
> > > -	if (this_cpu_read(nf_skb_duplicated))
> > > +	if (current->in_nf_duplicate)
> > 
> > Netfilter runs from the forwarding path too, where no current process
> > is available.
> 
> If you refer to in-softirq with no task running then there is the idle
> task/ swapper which is pointed to by current in this case. There is one
> idle task for each CPU, they don't migrate.

Thanks for explaining.

I am going to place this series in nf-next.
