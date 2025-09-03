Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCA303C88
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Sep 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917876; cv=none; b=nM/XStt4q0hugabBUDaLs2NcrxPECHxfUhjoFuWEN/jrYXOpm4JJ4rSsPKxRNFz1wnDznYpgn4eUglXqMyliDmUnU83XRsoLYJhE/T+hwn0X4ufMXhLq9ipOJhp42Ix0LKHDx0Z7HkkAsVKs5/aeE9wZmpLdlpwC3k90mUtQHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917876; c=relaxed/simple;
	bh=ariY+FcwAGaGYyROXJ//ip+a+qed9bzuJqi587Emzwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWp5Tzmz9TkIBpWrMPmuYdpnnc23M/eahLFgS7WNwspHiOsAP/MPKgXzZpYKFxP7mNrDAPT02enD3hDyuYDtkFJGnHmHZfxRQOHIBBD5j8v/RkWTVibBIUDdRjeI36+4mgvqqNGSTy+KzPZj23mkYt5E/GK8SI2dxR9gYZ+Xv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61ce4c32a36so31507a12.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Sep 2025 09:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756917873; x=1757522673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9FL6tV8n13zlBvWYA3e3xfxYg9pjFXyRGdxyyVqxgY=;
        b=L1IN4XtVM0hcvv7AXZ7CPr/tm6twDrfu46OZukpBpoyS8EhdJdscZmZCA91ashNb2x
         +flU6WYiM1wwspreg5sT/WrYViXvrQXQWcKwvaMjgwMlhFrKklfmOqepQpHyM40e9oeH
         6VYWaxWVTR8yttkiBnp7Ch8WWWqkQy5Yn6AwwJxDfPLvv2KTR17TE1iuVBNN/gM+F1dk
         eIM1KZu4yTziqmT4ixZ5XfE2+xeiU289TUGc1sMTsEPH4+QJ68VssY8E419J9FiExtwS
         rV3WiwVe/plsXYsd6Tx0dYDHZrvtVcCFstgKHQigSt5BA6D91Tj/Hr3kwBPap/JxeXPK
         LZHA==
X-Forwarded-Encrypted: i=1; AJvYcCUJfmsgkoVUBW2va6xIf1cKnmjXBKboMKhhDcgYQMQ2p0T+79BskrQwK/6mlvym88JC2zSsRw31kHyzS1l07Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ7SU5eenJAEh5Ekz51rOEZS+wcSyr4Xt8pWUrPIxVW1XabjQF
	kvCnAOvXk7R5HVPoXkHsjBCUyjyxiGE5s/y2g6ZfnkFfxmLz0JzQ571Q
X-Gm-Gg: ASbGnctAJBcAdXhgERW4pKf2aXqS+W2HEGg6wCAVOePBDdfh+NO0SvHssJBy2kE9Z74
	fQ+0/+EFbBLgVydK3eEWDbdJQJ0avtK/cq7fgdkZ00WAzVMUoR0TfOXWPyE8u98sPZWhq044+5h
	1kIXRUZUtr+w3WUhjhKD0kRQp+355xEUP0FsAE/ORMPw8QfIUTPpBKqiy5yUG1m6RE4p12hAblL
	/riglkhs9ADngmMbcaXTNaWfm9kmkFaB7AHDkgwVT5PHcLy+heowMyr7v4bBgNub3XYnrzHvwJM
	aNmcdInERngzhuIl8jxvuAW+TRWehSM7/qDyIfx3H1PdHrhiaV/qW1NMUp52e5kUu7GKnlnLYFN
	q+aixKWYTud4E
X-Google-Smtp-Source: AGHT+IHfDVVrl1wHNyJKDwCmpxOKb3QmVNSXv+pI7nurrc1BarqU4QHmNG3rluy6cGrnQiIAHjnrBA==
X-Received: by 2002:a17:906:5909:b0:b04:1b90:8d7a with SMTP id a640c23a62f3a-b041b908f01mr1209368966b.27.1756917872692;
        Wed, 03 Sep 2025 09:44:32 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01af44a01fsm1099042866b.23.2025.09.03.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:44:32 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:44:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, calvin@wbinvd.org
Subject: Re: [PATCH 3/7] netpoll: Move netpoll_cleanup implementation to
 netconsole
Message-ID: <vxad5ijytxk66i2rja2uzmueajzpbccy3xcc4nokfnc6chapqb@j2kxvpyb63rh>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org>
 <willemdebruijn.kernel.2c7a6dc71163b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2c7a6dc71163b@gmail.com>

On Tue, Sep 02, 2025 at 06:49:26PM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> > Shift the definition of netpoll_cleanup() from netpoll core to the
> > netconsole driver, updating all relevant file references. This change
> > centralizes cleanup logic alongside netconsole target management,
> > 
> > Given netpoll_cleanup() is only called by netconsole, keep it there.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> What's the rationale for making this a separate patch, as the
> previous patch also moves the other netconsole specific code from
> netpoll.c to netconsole.c?

I just tried to isolate the changes in small patches as possible.
previous functions needed to go all together, given it was they were in
a chain.

this one netpoll_cleanup() is more independent, so, I decided to
separate it, making the patches smaller individually.

> And/or consider updating prefix from netpoll_.. to netconsole_..

Good point, and I agree with the feedback.

In cases like this, should I rename the function while moving, or,
adding an additional patch to rename them?

Thanks for the review,
--breno
