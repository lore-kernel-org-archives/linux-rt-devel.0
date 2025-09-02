Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5E2765DC
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853370; cv=none; b=YpZXL3LBOu2Q6BwRJi5B1UQhHu+mu84JwoEy9nWxGYCF/jQFqfVc33fMxEY5xkulWpKjZGdjb/mFhTBHfuZX7KfuRxcNlYb+rTg99/MVMUPSuW418zy6JAbBgNnYiK8wf6eU8Ex+PrD8X0qQARGVpRa4YnizXh00B98jyFg/2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853370; c=relaxed/simple;
	bh=x1fYtz/DGQkJOfME3HltG5aYcqAWCkzmIqUC3vT/gOk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pT1AlvwSyXiXHY1JGnCt1MBb9MZsUbahg3RadSrJwCnotzBau/fdFfPhARZ6cdI+yG/Disdv/amJj1Qgb7xSDuYhB/uPIKdYetECUZX3wZptT8YPBv8UoNBg695NVsWratuejuoBi8XOzBKOcHYsih5feV1nwnZda4M5zCXRqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw+3dPtx; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw+3dPtx"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b30d09da3aso53428341cf.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 15:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756853368; x=1757458168; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/r8KI96FLIsXt7BTzjZmeT6WOrie+H7TpW2dI0xAa0=;
        b=bw+3dPtxEWX7Fc1WGJqTziU3U9/d8ddELEoJRGRCSKMfkWGcxflNdak2ueXkBGpHd3
         /6egessMtKuhKblZ1kFX73fJiE4y91y31MFGuP7v4uXZymAKgN08okuSqwux9zBPtkMN
         zWHcz7GZQ2lz3HCvCaI/IH+dqHedaCGTrjbC9yIC5jh5trDwVDLhbl/lyihM1GVDUdzU
         esiaXiRw+x4jv463BveidQZxxA4hrfijfskim5bJum8S76DhvSwpl6/hXz6V1LTdevVn
         slefN0aTdU4BbMQda1fsjy3Zc+zs6atW5rHNn7G7GOMxnCEJgRxyTU6zBVipC889Bb/I
         E+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853368; x=1757458168;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W/r8KI96FLIsXt7BTzjZmeT6WOrie+H7TpW2dI0xAa0=;
        b=v/IEDkx1YH9+68jen3rjgbanlfRfFyDJ+JaMilPvmYRYZCXtpgiV36Xdsd8tb46iMA
         nC4gW1LL0x88EHnSfwCIP8ZVh7sMyr7yXLD5I4NKPQhZwItRVtnsiAoCaZHiasBDdoIf
         9aaqQ/q6EU7yYGH0E9DpN9pHv4cW2LpxuqUZ84mu5O8c8kjVeyYI4WlM/SDbG/RXTZ+U
         N4MvONJNDqDvPKtY/fi9yswFU3bpma/ia9g3Tg5rO3C07ToL7h6S0NtsWe98doGBf/ae
         tN+xO8zP1ff75vpHc0yfUc4ocsxbAyC9+XITPfIveJmIfD5zQFZKi1Hd/cm31fpXfFpq
         /HGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGt6ShLI6C+bxJku2iDYSHCL+BhFTLAFc3FOL2++L2glS1bvfZFm8czkc6jDO9oqCWP755bTSBZfGGOP1CEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdPnBgefeQ0+RkIwq7fVon1IQxAAo9RTjAQtGogduooeDvxIji
	k3R3XchsPKbmg/IxZWrnb476vDLtnZglauJFlexsI1mBzq35B0b2OwfJ
X-Gm-Gg: ASbGncuEgT62uppQcm6eTmEiiQIN/+AJuzJayaWxRVf7wKQnW7rhkJOms2U2NB0pnzF
	Boql6Rte23nhE9Hu2G4/MS2pVrG/5Z+fVk9edQ7Zc//4p5gxjhzTSrAP6Ol0NFglxIwSGsyGlR8
	cptb95LdpKSvzjfLDsIL/QT+Sc5w2b1ntKu4eXLoBYQstBqnAp9Yr6LDvPiQyxNWBJY6WQUf6qH
	E8aq78iPAjdrLPkJw/w0TrSpozWrbTY7yfQue8EY2l3iS/YJNsca067KE7N9zA7brYxVpFtHvZd
	bZnUkWRWJn0cNYkHjAQXQrQn0zCmgp9ziCPecLqxikpF6YYWGE92O8YeDUa4yp9KvYQr4nFBAp7
	KP4hQRyVh8NSyFRVQ2y1sjBZeSLsxC5cf4LBTFvRF0YExW7+mYQvShbJSqAfe1jFqG7SaUFGwfY
	nh8X2PrTB+rOgV/aDQY05dXe8=
X-Google-Smtp-Source: AGHT+IH46xUXV484hnHXmXzWd3NGpG10mKGi1xfUd31g1IcLmOmEJG4dfsIDEM5/R7lCxuphIRt6qg==
X-Received: by 2002:ac8:594b:0:b0:4b2:eeed:6a17 with SMTP id d75a77b69052e-4b31db69339mr165830391cf.46.1756853367702;
        Tue, 02 Sep 2025 15:49:27 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b48f7823casm2163821cf.42.2025.09.02.15.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:49:27 -0700 (PDT)
Date: Tue, 02 Sep 2025 18:49:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org, 
 Breno Leitao <leitao@debian.org>
Message-ID: <willemdebruijn.kernel.2c7a6dc71163b@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org>
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
> Shift the definition of netpoll_cleanup() from netpoll core to the
> netconsole driver, updating all relevant file references. This change
> centralizes cleanup logic alongside netconsole target management,
> 
> Given netpoll_cleanup() is only called by netconsole, keep it there.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

What's the rationale for making this a separate patch, as the
previous patch also moves the other netconsole specific code from
netpoll.c to netconsole.c?

And/or consider updating prefix from netpoll_.. to netconsole_..

Just two considerations. Not blockers.

Reviewed-by: Willem de Bruijn <willemb@google.com>
