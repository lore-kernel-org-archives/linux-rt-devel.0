Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBB1DE3CA
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Sep 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919636; cv=none; b=Vizo+t6SiP+0yJlqI0VaR3nj1UrBC4CDHtDUC1JzuJnKCv+goxbthvFwm+1vZWH3IrMB7ypCMsH3XQdR6jEzHCp60vzVCzu/BUKN3gAM+XgDgRkt7X59Z2Hs4W4EzyCivp+v+40lO+13bn5KAFRP+uszeTwJdLxvTYEubAXd8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919636; c=relaxed/simple;
	bh=C2hAY7INmvGsaTMg5VSZEHBuZuox3UqW8ARZQkVGI0w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XAUtJgFbHTZtL6y4ZmmvGgh0s1WlcehQ3euw+VpkykTuKHKQPu5igo6u1f04gpd9/mzVZpZS7yYubdeJTGc5qe2hAF14KS2vHE0VrM49UBWW5QojVNlJhyJz19jhUnUl10nnGoaUaM7G7/iEuyLzV3J4yfzPVhDLB6a27Z4M/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csLiF00c; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csLiF00c"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-80e33b9e2d3so3311485a.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Sep 2025 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756919633; x=1757524433; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx3EdG8+5CrX23Fe+Kej5I4NIXOHb8mYU2LURNAI8JM=;
        b=csLiF00cAkxQ7kTJOweijUchsepVCTp40LGH7TUGTO/tKjyBO0qPevB8cJ5KXCd5jB
         zkZIgPzymlBkuCWOBds71VV+Dl1RisHbUi3vNBAjy604rauT7xFbyQ21ivnFt54U2xIX
         MJdaJJLeytzy+x7yLYmlmP5te+aidWStUYxZft8KCciGlz/wuxRZlXIy4NM1hLVm0Ni1
         oOE7sf8sOVZ0ZQ18iVgQUk74qu3OG/EfDWRgE0jQNf5YbRM1B9saRZbggumzte9arQFK
         oamJbQWtCw1uvu/jFEHxFPfJNPwqwll4mT/P6SWfuEZ7bkOzJjLYJpJ2MtDnzj+yQ86/
         FvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919633; x=1757524433;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nx3EdG8+5CrX23Fe+Kej5I4NIXOHb8mYU2LURNAI8JM=;
        b=Kj1fjTEmAMr/UxOzYPXG8KLu6ieCe2dkH4lGxdimmMKQdHkfxF0UuS2bUBWd4ZKhX4
         ts3qi9TnvuG5fPKyLLzJh4jMv/LX/uU02rhXJBFnpTb+o1426oFIQRQIuiY1HR23UKAS
         KLQUYdpYCz64y7C45jKf/VgjIaNQUvJQ9Dp6YQx8RFMJ+WJf2oeQnvClR7rf4t4zjXfE
         IqUKqsTuRs0Zl9r3NlN/5ss9hROu1k0xFJCcBzz6w3Jn9rGipO9rs1db1JHWULVmhrJs
         oLE4lhWs974Yik+uQdBr4Kgif2tK2WmFmcg83WSels5EQYLCWQ9zSnsEYoVOyqZ1KjpO
         WgHA==
X-Forwarded-Encrypted: i=1; AJvYcCXRCl16yn00hkk7dJY+wzuCiMgT3MyOM2j6OR7GTxZH+22PRL5UE0Pas1LgnyWJbgPM4Fr6MrcbdS/TA8GICA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp55aOKAiaJupEsikNIXfqeXSNF0w47F5mR3Lt2Ir4FUVrUuBs
	Mp0gvt2zQsSVECT7D2wHXLIRWGLrT8IJDGFE05XhWKXp1dlmxuFnxQqH
X-Gm-Gg: ASbGnctncvj1M5JhGsiET/3JP6aq/G0g5zndxhNfHC4/bitV2gVbzJicR9+930XPvop
	GvDQIIhQWk3KdFJjs5O0KSZMLdbJw6s/0WsHXB9SU4300iQM0Xg/m665qgjQf1XQ9i462KOk9bC
	Wl/n4cESqL1qzbl8x4mOnMxDEHmpOLUVYDmGrKh0VTGroUYtgub2k0RyZlpMjihce65IiMAXUP3
	UEp1lMSXvJc95LZ6mC6+kVRtT4zSUPFU2El0xy0uKwxWVDOCtHdSxChu5Q14j+SFGWMkfgLj4in
	hrYG7bxLHLZICk+rbinLjZEi/Jan09r0hsqAmtWV30HIZ+u7xY407hHLhTCHh52liVg/jITgcEk
	gD5nDxTs+z76T68gDM1oq6Jw8TDddpQJjIQ13f/mshwmlybgm5W4AGYEKlHxBGoqb5CcQNsYVdc
	6lGg==
X-Google-Smtp-Source: AGHT+IEyaVSC4HdW7YbvHVPqoMIBDbFbLTOUFyGpAyq4No9jI8fwuxQGryVgkoZi197op4qNDs6+Yw==
X-Received: by 2002:a05:620a:2544:b0:807:1e23:8100 with SMTP id af79cd13be357-8071e23923emr706686185a.36.1756919633490;
        Wed, 03 Sep 2025 10:13:53 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b48f501690sm14876011cf.0.2025.09.03.10.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:13:52 -0700 (PDT)
Date: Wed, 03 Sep 2025 13:13:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org
Message-ID: <willemdebruijn.kernel.14cd8a5376059@gmail.com>
In-Reply-To: <vxad5ijytxk66i2rja2uzmueajzpbccy3xcc4nokfnc6chapqb@j2kxvpyb63rh>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org>
 <willemdebruijn.kernel.2c7a6dc71163b@gmail.com>
 <vxad5ijytxk66i2rja2uzmueajzpbccy3xcc4nokfnc6chapqb@j2kxvpyb63rh>
Subject: Re: [PATCH 3/7] netpoll: Move netpoll_cleanup implementation to
 netconsole
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> On Tue, Sep 02, 2025 at 06:49:26PM -0400, Willem de Bruijn wrote:
> > Breno Leitao wrote:
> > > Shift the definition of netpoll_cleanup() from netpoll core to the
> > > netconsole driver, updating all relevant file references. This change
> > > centralizes cleanup logic alongside netconsole target management,
> > > 
> > > Given netpoll_cleanup() is only called by netconsole, keep it there.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > What's the rationale for making this a separate patch, as the
> > previous patch also moves the other netconsole specific code from
> > netpoll.c to netconsole.c?
> 
> I just tried to isolate the changes in small patches as possible.
> previous functions needed to go all together, given it was they were in
> a chain.
> 
> this one netpoll_cleanup() is more independent, so, I decided to
> separate it, making the patches smaller individually.

Sounds good. Thanks for clarifying.
 
> > And/or consider updating prefix from netpoll_.. to netconsole_..
> 
> Good point, and I agree with the feedback.
> 
> In cases like this, should I rename the function while moving, or,
> adding an additional patch to rename them?

In general, it helps review when move patches are entirely NOOPs.

In this specific case, if this is the only case that gets renamed
*and* it is such a small patch *and* it is a revision of an earlier
patch that has already been verified to be a NOOP, then by exception
it's also fine to squash.

If there are more renames, it might be best to bundle them in a single
(otherwise NOOP, again) patch at the end of the series?
