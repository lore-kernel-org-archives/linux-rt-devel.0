Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284284;
	b=goQnshDgYpd/MD3ruSGssmeXDDikH7CHydV5z0pJhq1twkV8EHX0juK7L6PKVCRzkcVJ
	 fLuB9d9mI6dtxmo7RhBKANFg/a6V19iSNvvPrOfJPrgoUe8f3BrjaUXJAMQP+wVbnoFfm
	 aVuSaTKbXxhn1SG4e7dFYI9Fd3PcnUv6OCpaVPhceW/b6MTQ6eFtyf2iE24pvdmNX5zvu
	 PFSVH2ntroxbb9MbeR3e3bj5kl1RLtpiWTb3TGYmZ7OkvDcPmkf2G5v+xSmxxmHCoVqpa
	 SmWTTSrijimUEq2DwEV3vEpVpst5SM/fH1ndkSGGUeshHG9ZtFgiByEszgYh74swxFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284284;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=01nmAsoYPJKA+BrrlSiNtDfrv6z2N8+l8YqH7IDGRcI=;
	b=NmZ3kRy09f+jOH92w/gHrwvcipaaePuEkYldQ1UKtp6UeNjQORSvjN2rZ6jtrEdN0llc
	 4qwwBYR3wamkWCiUGukri2N0w2lezQT/m44NjG4yMR+hJO8hprup4jaNCA/AwccWDXULu
	 /hiQ7Rnl0q1zyyC1ox7AXjaMNsGNvBNtjKpCtjsp+CG/Io8SMfG/YArqNv2Mh8EJa72E5
	 qglsJi4Z16v8xz215+BiXbroJr66TcUHug9kc4dQ26+iTA0LOjbF+JCQ9LjUBdbRusBjp
	 DDbaX18ahGcRE87U4UbJmTl0ZpIQI6u25rk6h2bxskJa1IOE1I5QBsLYwCEaMwea0BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yLW1Gt9u;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8F606A31D
	for <linux-rt-devel@lists.linux.dev>; Thu, 29 Oct 2026 14:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00E8F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yLW1Gt9u
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 7759BC0404;
	Thu, 29 Oct 2026 14:31:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id EADE02002E;
	Thu, 29 Oct 2026 14:31:18 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:31:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Anvik Loitongbam <permissiontogallop@gmail.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Olivier Langlois <olivier@trillion01.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] io_uring/napi: fix list use-after-free on PREEMPT_RT
Message-ID: <20261029103117.50aae919@gandalf.local.home>
In-Reply-To: <3fa26fac-5317-4c09-a181-c9c15e124972@kernel.dk>
References: <20261029102244.141621-1-permissiontogallop@gmail.com>
	<502f31ed-dd70-469c-b433-577ccee36c3f@kernel.dk>
	<20261029094842.58dc252d@gandalf.local.home>
	<3fa26fac-5317-4c09-a181-c9c15e124972@kernel.dk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4imy6fuq1gw3qz839ne4ra8f87xkf4j7
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: EADE02002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+JjW6nO4iATk1vhHY5G07RHKR/Uknq/JM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=01nmAsoYPJKA+BrrlSiNtDfrv6z2N8+l8YqH7IDGRcI=; b=yLW1Gt9uOF9d3jofjHLXly8TvL4ePv/Or19oXbgLrLm2x7i/OEkGz2BZbM2VwgAApsiRS+GjidI1dAlVxtBaEBVDGXS5npYDFdAwA5ZT4d6RMzCKGErIQxIo2gZxh7la6j2Z+DvUsKxt8yUFrj22gMDHR0p+exPFf+y6ucH3i4I=
X-HE-Tag: 1793284278-788853
X-HE-Meta: U2FsdGVkX18tlO22/dU+v0bLBcjGy/MNd1iHM0GJf4s1P3ZPPyejYm/PybPM6Oo2EzDV+CzfKqwapgcI3dLKaGXlOIzMKsMciDOociJfLK9gjrD6PflnPBas0alvblkhG4Y7QS5Xcn8fJN9uv+8fKYPDNkUSgUs6Tp9CylhQlzi1dMbSXSq3iOsg3DD9vRUAEeeRm6y7PLbIk8Lh3YTaWTJbIyJXFhF8rSprdP6H6m+yMqmHR5g/wX1O1Fp70a7ioQqgvAWC7NeHlepL/U81ZUYz50eR0PUJDfFQzL6UDaFRCnoO7xuQB3WYICDIWtp/

On Thu, 29 Oct 2026 08:28:13 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 10/29/26 7:48 AM, Steven Rostedt wrote:
> > On Thu, 29 Oct 2026 07:42:09 -0600
> > Jens Axboe <axboe@kernel.dk> wrote:
> >   
> >> I don't think your analysis is fully correct. On PREEMPT_RT, spin_lock()
> >> should still be an RCU read side critical section. __rt_spin_lock()
> >> calls rcu_read_lock() after taking the rtmutex, and then
> >> rt_spin_unlock() drops it at the end. There's even a comment on
> >> kfree_rcu() callbacks in there too, it should not be able to run until
> >> napi_lock is released, which is post the loop.  
> > 
> > Good point.  
> 
> If even the preempt rt people can't get this right, that's a little
> worrying :)

I really didn't even take a deep look at how preempt-rt was involved. I
just didn't like the assumption about the RCU internals in general ;-)

> 
> >> IOW, I think this patch is unnecessary - there's no bug there. The list
> >> safe change could be done as a cleanup, but it's not a fix.  
> > 
> > I agree, it should still be applied, but as a clean up and not a fix.  
> 
> Sure, like I said, as a cleanup. But would need a resend as the
> analysis in the commit message is entirely wrong.
> 

Totally agree.

-- Steve

