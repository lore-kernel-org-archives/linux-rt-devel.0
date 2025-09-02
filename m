Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADF277C80
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853060; cv=none; b=Ij4M95JgDRFDyZszoj9jTuAeEb2Zf1V1JGfJMsvSnbqWeWXWMqhJZI5IhILpAJflc5O152Rj5HDbNFlWMaXTeJktGEQyZsHyrB6qq1VPrNYgxX8IVmBydIoiB50Sch87PWYewVpfLYSOt8CJcI4kny97cNmHEQotcqywOhfQM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853060; c=relaxed/simple;
	bh=pDElXPlxysNWbmacgYCCIjzT8CBnCZxPfNk0jsnb1do=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YHHKyR+UADrun4Co+cc7FmbLruMTApeA5+kcrzG/KIRXWdvISlP1p9ncG3T3yFUdKbs8eVjt+1g3F+yyxqPXXLh7DTPkqU+F0jb1ODycwK+KbAX0UA/dK1OhCOwkcgo6+WQ0dlGAB70OGN8yDgsaTLy5av4x7mczkUvLhmcljzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap7iqiEZ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap7iqiEZ"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-544acb1f41dso1373315e0c.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756853058; x=1757457858; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSjF4T1Hwo77xpCNosIzPOB627gBX9Y5QCHwTlQLO+c=;
        b=ap7iqiEZPBSLC7/V8IUdcNXCBRTS4tV74U3N8dycLeiCeu0kjkNKLeDJrwakXJu21z
         ITl13sIuGXk4RFpPorlxk5bZOP/FwQRUsUEkEuK4GJHfc8syBLQK5NFm1ljlCa9cgrAs
         id1eNU6Ohl1WQHH5qXzZ4eu7Wg45j6U0O0N4XnVAiWhRqMISy03LzHxkGKxKhRdKXewO
         IkzaRtrdSHhOY2ImaRe8vI9OJtCS8dy9rbX1TZ68d69S5y9zKXWmch1gPU1UJIIgONW0
         WvYvVi1dCZRPCp4Bv2zpvNcfP3oV1lmKMDVDXXsSwxcYf7YgAQP7uCZSHRASIF/C4RQt
         bl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853058; x=1757457858;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SSjF4T1Hwo77xpCNosIzPOB627gBX9Y5QCHwTlQLO+c=;
        b=lwzupk7oYZf1HFCaYcpcNGuQuT+BHT7VkKL3RbPPI3WFc1qBXhvYt71t3rB6zh4f3p
         Mm9+yWM2WlxeGDCSyFt1MCb0MPKlyama5PJgUSmIjtIMrQ2yhw+kOqoC/qlXz5JYAlHg
         dHmaH8Da6MTq5K1lrc+uD7smRyHZ8AXX66ZEA2xWbNZNO5PbD4vMbgMLgpug/UPli/3v
         ndZvuU+BrWjMFZnNqz5Xdz3gSGEGVvdH/AGm83DlJjTIZY0bcQw7nSmEkIrG0+XNPPEZ
         xJDCTdhSI3eDabLpkbmmoMw3GHnZ9e1ukEiE13DV6cVMZHNTASAnwqgHouaYgJwjocLl
         19Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVeExMnBvJkHaC805sWVZpAeJSqO4tHluIYMa37myvRKj3NRcgQm5xfg0JxVB9n/PPKGSL5UjNvt/KmNrOVOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9OFu8QNavNV92u9a3F7pmFgM97Ey3peLnONSRTQ1MbDbGBA+D
	XseD9alB1HRiaa+EKHd1MJ929a7ag1QstC0+xCS7KlqxEvbNwnaEoaRi
X-Gm-Gg: ASbGncsisiNhiK+Pwv4VOehFuLa/yKw5OkYuGsqcWWvT1GLAupcauXhnAZlrtRLVWnJ
	3jtwr/ZN9xIu5nV1IfdVylnZTbf/RUSUVZDd+JxL/hUezwg71+LHyX7rIk08QgVwihy1WBSygdV
	67SdTbztQAYT5VJ7fhW7xwUFI0MmtWJqrozgbE3w7BT/j2Q6RBOh8ceZJTuTTW0EDE+RgvAyVqM
	dvYBV82b/X70IHFarDw1VXy6j0EjLm9QTPGYyG+aN9lwBICrLTGyiLg+v+cGZ91X7BZwNkRkgL/
	wZEpNiIYVHr2InH7AsATTszNEu4tMYFWzsY/t7ipPDp5o9CVajoBDRl35k4vFp2PxjLX800h8DW
	sNmccHJVihqwb4QLNDCcJwd4QrauMPWSlv2p5Fh9YEtqm8WTr2+tij9eTrur5kSyTMhV3Gf5N54
	kg5zcicGtVH+O2IpfRDubqcgQ=
X-Google-Smtp-Source: AGHT+IFBUwYB2UafAJcoVgYvi5smXXO0j3kJPgVySw53HU05l3de4kuy/loqjzhuufm5UUWS2SQATQ==
X-Received: by 2002:a05:6122:1d8f:b0:531:19f4:ec19 with SMTP id 71dfb90a1353d-544a02a9c02mr4052236e0c.9.1756853058146;
        Tue, 02 Sep 2025 15:44:18 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54491464b0csm6067110e0c.18.2025.09.02.15.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:44:17 -0700 (PDT)
Date: Tue, 02 Sep 2025 18:44:17 -0400
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
Message-ID: <willemdebruijn.kernel.cc9704ca4054@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-2-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-2-51a03d6411be@debian.org>
Subject: Re: [PATCH 2/7] netpoll: move prepare skb functions to netconsole
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
> Move the UDP packet preparation logic from netpoll core to netconsole
> driver, consolidating network console-specific functionality.
> 
> Changes include:
> - Move netpoll_prepare_skb() from net/core/netpoll.c to netconsole.c
> - Move all UDP/IP header construction helpers (push_udp, push_ipv4,
>   push_ipv6, push_eth, netpoll_udp_checksum) to netconsole.c
> - Add necessary network header includes to netconsole.c
> - Export find_skb() from netpoll core to allow netconsole access
>   * This is temporary, given that skb pool management is a netconsole
>     thing. This will be removed in the upcoming change in this patchset.
> 
> With this in mind, netconsole become another usual netpoll user, by
> calling it with SKBs instead of msgs and len.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
