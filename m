Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2424BCE8
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600840; cv=none; b=CsWPmXwCa5OjfjcY/VgDVj3L/nwQYK3sEHQKE8XA2RhsGpR3ZeCvK07Ax52AUjVFpI3FIOe/otKqgnqilLewjvkRzR1oYaDqxE3Gdp3qzRiAjMJjyQn5Pu7C6E/k4MaAHTkpQDfTXjCbJ6TflOYtFPuJ8Ns7k2ETABv5RC6dSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600840; c=relaxed/simple;
	bh=FPrp+fH8wQ80pVHpy1RyvyWQHJ1VB8e4XUj3uXXKyQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cwqETV/IiQLqeOAQix3pZbfHK8zDqKzplyROy2Bzd2Xfdhyt5AEz567jNDcNRFs0cpqoAmE3m4oVKmy74+GpL2v1uf/Xv25uG+mcOS7+DVVNPJM5NVoPRvOknxODGPrgLK28yXvqPsEd8971aUfaAhjCw1Ckbj9kXWcHfQJb9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0/EQ4wG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0/EQ4wG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752600837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaSiBOF1wPWOTv8AtgeF8xVaaHSWbgZKOuWdwXI5wu0=;
	b=C0/EQ4wG491Kxd1GeP/rpvZLwRZcc88D1Go0OEIu8cTE8584v49WORMPXWDQLyytVEGLVy
	8eiv+f8WGJWkLlWdblKd7ULS7Zg5eyZqjDN4CX88sg+aF5xYHI5fMqU9KLh2pxTX4roC1D
	Zv9Y7S6x2VDuehoEXDX4OCHc4+7N8cM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-xf62knZCPbyasSJqNVzQbw-1; Tue, 15 Jul 2025 13:33:53 -0400
X-MC-Unique: xf62knZCPbyasSJqNVzQbw-1
X-Mimecast-MFC-AGG-ID: xf62knZCPbyasSJqNVzQbw_1752600833
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so2213640f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 10:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600833; x=1753205633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaSiBOF1wPWOTv8AtgeF8xVaaHSWbgZKOuWdwXI5wu0=;
        b=Hzfo0oGfbYofOqX52GKk2lAk6+OyB8sz+hGYPyIie4fKaljB7oaEPLvyy0Q25FQObv
         LvxMe+ZvgdyoTmPfyRjTPbXToDQJa1k/0qzwsCJwM4nU1RWDS32FsqoXe1mL3hI4mSOv
         kCahL+i6DGq4/Y0DdbECe0HvnvALGcMSaeFsFijDMH1mjUU7fzECzFZQsDSnPN5O7fM7
         ghttT7vhihPxNKufwAo1QIzSr6fV+owznI7q3UrSJcIR0Zubj4xpLx8OfcRQokcIXjP5
         TDuGje4PcWcLEFYl/PTGHHVkVinWin2npwhejAtX3SlvPFnstc48z7lYTlskeeGiucRF
         eueA==
X-Forwarded-Encrypted: i=1; AJvYcCVzA3Z0QtxxR6jNQqLeAsjFwQgP74q+4vLNjiml8FilrphdeD9HHkTS7V0z5Q5+oVwBNsdarPIO4ALzWYxxwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo4orzsqIaS/EljBYSdTo4XVZBwV8xBnfZ5IDhZKJUav16+v5G
	YQKWzDIVBnY78IhSrHs+pMiu5UF9eqVSYmCUlJPmqJ6608GDj+3zn3GlYnjvb+RfrW/kNXlczbX
	O/0n5BqxONXy4bLKghEEEaE+9EBzzzRAiRt6nCP7FToKOf2A4TUP0rJNxI80iOHP9J1eX
X-Gm-Gg: ASbGncsu8NQCTWXQ93leOU+rmlTxYR8new11/o2BpHA0NpuROnqCrNl1p6FtNIkPDXq
	Jj2S1JBzwzwHFl2qB1TjQyjvp5IIGQfCH7pfQp1HwAd9MBPEMnIeaH4xBk72/w6tBI7PUbIIc6u
	KHx5/TSJG+5KkyUz+26Ta1iwHIEiijUJeMqWM2QJocDoOc+7Vm+AjxUvGRWbALtZzMMzsRSYTtX
	n7D2fJNVxbYmPsc93CG9oUG1R3bg06lZXcb2FAJJVewh2E6N0zp17/eMnRRjsa7IsVNdaM97Nlg
	MK0tyPAqO62DzOwd/UUpBC/v1jA=
X-Received: by 2002:a5d:5f87:0:b0:3b6:463:d85d with SMTP id ffacd0b85a97d-3b60dd4b599mr60669f8f.11.1752600832702;
        Tue, 15 Jul 2025 10:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+0cB2h3qUzp+CrQ+V3JIFurhf++QRbNMS5r7Z3JeZZgdTqJ5fZlkHZ6XnPGFSQzS2Qf+b1A==
X-Received: by 2002:a5d:5f87:0:b0:3b6:463:d85d with SMTP id ffacd0b85a97d-3b60dd4b599mr60646f8f.11.1752600832314;
        Tue, 15 Jul 2025 10:33:52 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1776sm15883259f8f.12.2025.07.15.10.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:33:51 -0700 (PDT)
Date: Tue, 15 Jul 2025 19:33:48 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-ppp@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Williams <clrkwllms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next v2 1/1] ppp: Replace per-CPU recursion counter
 with lock-owner field
Message-ID: <aHaQ/DZ3U/Sxd7Rs@debian>
References: <20250710162403.402739-1-bigeasy@linutronix.de>
 <20250710162403.402739-2-bigeasy@linutronix.de>
 <aHUsB04j+uFrUkpd@debian>
 <20250714200139.tgfgVP1L@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250714200139.tgfgVP1L@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: icT53ahl2zsSoN6nDz01xKTgbmTO-o-tweo8M94Ys7w_1752600833
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 14, 2025 at 10:01:39PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-07-14 18:10:47 [+0200], Guillaume Nault wrote:
> > On Thu, Jul 10, 2025 at 06:24:03PM +0200, Sebastian Andrzej Siewior wrote:
> > > The per-CPU variable ppp::xmit_recursion is protecting against recursion
> > > due to wrong configuration of the ppp channels. The per-CPU variable
> > 
> > I'd rather say that it's the ppp unit that is badly configured: it's
> > the ppp unit that can creates the loop (as it creates a networking
> > interface).
> 
> I can reword this.
> 
> > > index def84e87e05b2..0edc916e0a411 100644
> > > --- a/drivers/net/ppp/ppp_generic.c
> > > +++ b/drivers/net/ppp/ppp_generic.c
> > > @@ -119,6 +119,11 @@ struct ppp_link_stats {
> > >  	u64 tx_bytes;
> > >  };
> > >  
> > > +struct ppp_xmit_recursion {
> > > +	struct task_struct *owner;
> > > +	local_lock_t bh_lock;
> > > +};
> > > +
> > 
> > This hunk conflicts with latest changes in net-next.
> 
> Thank you.
> 
> > Apart from the two minor comments above, the patch looks good to me.
> > Thanks!
> 
> Okay. As of the people involved while this detection was added and
> polished, do you have an opinion on v1?
> 	https://lore.kernel.org/all/20250627105013.Qtv54bEk@linutronix.de/

I like the idea of having an owner for each of the locks involved in
the recursion. That looks cleaner than the current approach of selecting
strategic places where to handle the possible recursion.

However, as a reviewer, I agree with Paolo that the diff is difficult
to reason about. Reviewing the v1 patch actually requires reviewing the
complete PPP channel and PPP unit transmit paths, with all their funny
features and lock interactions.

So I'd prefer that we merge your v2 (or v3). Then, if you really want
to push for the v1 approach, maybe consider proposing it as a follow up
during the next development cycle. Note that if you do so, I'd like
that you also write a selftest that could reliably trigger the
recursion when sending a packet through the channel and when sending
one through the unit.

In the end, I'm honestly not sure if the small cleanup benefice of the
lock owners approach is worth it, considering the general difficulty of
maintaining the kernel PPP implementation (brittle code, questionable
architecture, almost no reviewer).

> Sebastian
> 

