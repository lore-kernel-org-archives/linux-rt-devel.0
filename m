Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FBE30E0F1
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826616; cv=none; b=kC7R0hE8UpyaxqvjrKKf+GpV2KLrw5TpN6abBzv9EbKNEsKoc97X//L8Vd/LhUdFLexLHWr2LGMNEKE1UV+m5uz976g9zxp8cLZ1/QHyGEU6jcsue7X7kUuu1rllpnXUhwcObh/SjEFpUbu0GvYme3fkFimSwHOTMpNRZsLAERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826616; c=relaxed/simple;
	bh=djnGVHCYiTjuSia2u0q6T+YLWCnZ+7UiAkbLWyydC5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJbvrRdyLELj5XTchsIG2PHIpBnigp/iRJ3fX7BX3vEy0ltb6BNnjTLEsolBWYrnxIF+MtJlgcG3qRyHgE4vQXUOh1sU/ZJwicVTgY5PwBlYWPxUVxVLVGmqFMsYvIF//lallxivsoVPt4MZeZSl5KOxKL+JeEVewIWxjUIT2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so5819077a12.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 08:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756826613; x=1757431413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djnGVHCYiTjuSia2u0q6T+YLWCnZ+7UiAkbLWyydC5s=;
        b=ZEqqs2+XOLvn4mvyw0SF/+ybK9mzlDA5r+tjIKkOcBgdhcsrlAsyE2+q5CnYHpZVpX
         ZwcFEEpwwsaiDEnqDq27JqaS0ZlhSFD4idzEv/BKoTxfLsiLUP/4L7GSJzmHD/3AshWW
         G7P8hmkJygbjRR6n3TRvlpH8tp07DeajyRC/nOvIUUNDsLI9wiTNkZvyTDXn7JOTDc2K
         tsd0tfva897wKGHWES6a9SXtYPS8n173wrBzABgi6PUgllDK7lssSSvbsBNc1LJ9TO6E
         6T7SXc0nhy+ZUZ0V5blok9MrbbApvpsOapG9s73LJyAod4AktIXIDGKMJGmFvo5Phsqj
         DoWA==
X-Forwarded-Encrypted: i=1; AJvYcCXdxTpzPfodPhky1Twdplngg0U4p9eJ/J1YnbgBUuddEJBNb+1aat5kqfyUbljicdPTobckTILxPPVXSwcKoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx76+Lp09CaKLdGBebF79NIWILK+ZvXNQ7vKENM7DEUUpn2khRO
	yIiUW/Vj+9NzGu63IG8bxQNKTE80AXrunv+9psp+/43Z2SDvehOpj23J
X-Gm-Gg: ASbGncuZ+2d2Yi5kWBHieDe3BBX7u+EqzvKk2FMRtCHXalk4ViDEqdysqU/RC5slfuq
	4cFrXbjBB65/FF1Rz3prdC9tNm5XSTqJYfT63Y2fhngarzjBtMAYjAABFYjTYprbpWh9H4xx5Mv
	LNgDeTqZMfimIqgSJ5vuwuIV5PfTqmEUnWDDRubRmDaw5TUD7T3aAQ/IENf/JvVyaFkMjLEIq6W
	Q5DvW7pvcZocRmwDfxAtEVk1oaUvBdKV+bSzEF+I2PA4mJ0X7sl+ZU7Kf4+2Yi/Hg+OmlV1jCZy
	fr2FozqBicWCejc8EMWuedv6NNPa85525YX1YCVG8pTGJ5vyyz1bvzyPf133xBaBDVAtFiJANiC
	9XeKf45gf+HOF
X-Google-Smtp-Source: AGHT+IFHMWo3wDGvCkq0RM0mWV3QHrM0M52EgvwyERBSosR5NrkjDWOlCm4CFx8yli0QuWlqhLx/Sg==
X-Received: by 2002:a17:907:3cd5:b0:afe:23e9:2b4d with SMTP id a640c23a62f3a-b01d976afb7mr1389440266b.43.1756826612615;
        Tue, 02 Sep 2025 08:23:32 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0413782b94sm703116266b.35.2025.09.02.08.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:23:32 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:23:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, calvin@wbinvd.org
Subject: Re: [PATCH 0/7] netpoll: Untangle netpoll and netconsole
Message-ID: <7eqeiq2k4kg3j5442pm2zzp6bdflqui6bmwes3f7bybyizbc2r@n6riekklmd7x>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>

Needlessly to say that I forgot to tag `net-next`. I will fix it in the
next revision.
