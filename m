Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168932F743
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854449; cv=none; b=J7k/Jtg+YCCL68A5UsmGMtm90z4h/PPRbko9wTg4GkPU2uZxFhvzq+vix7rZB694E470S8m8H3V6HunNePnB/lW/tVclaA0C7m5I6VMqXmeFKdjbOH1E2oDI8fx5GR4iEWDyS3ZO6lgiA6HdmGoxLgKf2xDcoVUi8vUeiFbUNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854449; c=relaxed/simple;
	bh=/uq6p19+kImpEi0OoSJrJGM2gwYSXlB+zJgcs3LOSgM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IVnd5m6Psx36S/CqiveN29itm9VKpXQKTOXikTKsEBapsrPQ9Zk2oUwSwJaH/oQ2jdnRsiKetrBBHheEXv3/GkQiebkPQc2MLAhOChUjI+JKIHwQVA/PS7aELqOLaZV+f/TTUffxBSR1dbzTQY4283l0UiwRRhdW7SWtap4hAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ydpmh8Bm; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydpmh8Bm"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-544a59e1e87so872997e0c.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756854447; x=1757459247; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woWpwso7cgKxykh/N4zBwinfTsbNHangAXByJYsVVKA=;
        b=Ydpmh8Bm/ZrJePzhjhNa4fCE+7qbJRPQG8RbHuEnX6MEoye8WvQ9oUTPNRa+/ic3P4
         JuRjTpljTNHaSLy69j2ZsDA3x0ZDPOjtkAzIqrRxd5uNTwf8rlM+gZFGjF+BGMlTgguh
         XY8W/sOajEYnBHJWpgzhS+mza5ypGYgbIpfKaZETYJKgq38srG5uixKnkIq0vD1sM0Z3
         6D20EspsAB4s8ObOX6LECWBL0wnj494imW+BtM5bj78kVPFqaeUE1/jZYiv2dPr5OAYe
         f7QcVc8yMMZIlvwfMXY7BpOyaCdvcmRCEH1Q7bJrG1UWC5/mc+0j3THnKmkZjhC7Xsp/
         Re+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756854447; x=1757459247;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=woWpwso7cgKxykh/N4zBwinfTsbNHangAXByJYsVVKA=;
        b=BOteciByLGuUZYFgM1ELD69+z8N7oRrQoDbekU4LBjfrZb7JGLsW9NUHOinuJhgSrj
         VTpM2/ClacpOgT0xf1E3APwSB+XH2f8TtJV0c21IeeGji+rd79XC7OlGQJYw7Vkg0Z2u
         puF9zT37Gf6WFKDnMoi/8D/rfmTpdWRXHHx5oJNVtEWWAf7L+vYeYhfwF1uFJe6ixher
         wKM70b8RFMUR5lzxy+/taJzlyaGa0wPijoUivzxbgQtQ+EZKTIy2zIS59JhFtw0Y63bs
         RT9bwEi4vaaFYeTZ6qyMMaxk9tSJL25Rw79YWDQB9xsGgEf5sONvpV/lSWKDdm+OmqmJ
         LzCA==
X-Forwarded-Encrypted: i=1; AJvYcCXvYNL3Ck9oQvYoieUsjMzqxWXktvS0edPo+Horv/eyERblflk35hgwLuwBKPfS5yYWgZL6Zr127jWrzxyZgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLMaa+vB3LVKPOqr7MYojHhRfVPK7tPRba5PQCs6MwSXHmrDRP
	52lMopwtUdQLfEUSx+kTE9EimOedUW3uHd8usa6Ilbdh7SiSvStBzXHk
X-Gm-Gg: ASbGnctQrca7P0LdM850dYuyTc/DQrp+6maCepXzaVDsSui0WXBar1SAzr56Ob8bo4S
	ez//sybiPJcpnfPfOe4UloHkqdSR2BzWvquMcxlcr+t3YCTXNlxoBLK/j72Xx9oSjQxo3ii81Wj
	xcHEkIz/O1b5GyU7YsOYHv7PEQBPd9tiQqy9oXRqBe3FZOSuAXusXBlbFHp2H8rF83yIx9hc6bt
	yfVFM7lZwfTldfRPuKb1y8KDdLsagBBbgnDuBza/j+hfF4HuDfZoamUqdI9O6sNnumAXFKvT+tw
	ygba7bz1lj8tVlTEVSgTxw2LwSwK57gug+3se1Abp+ZsTuygmYmnWvZ6zIwuI2isgaz2ssJYUSG
	kny06RjeKgzq22aMdnyeJ6GvO6kYdSF/wDa8nzjX7BU4r/qWxXStPBo5k6RufW3eFqxmmcbOQCE
	cHHBFUhsDR6fB7
X-Google-Smtp-Source: AGHT+IEZTjN2jVE7iIOvoJv2mmhQmtLnMlwuRxMJZ12YFhcWNXX5n2JgpSNvjoZVZahXX3eevAbUAA==
X-Received: by 2002:a05:6122:1805:b0:544:75d1:15ba with SMTP id 71dfb90a1353d-544a01d3622mr3763896e0c.8.1756854447040;
        Tue, 02 Sep 2025 16:07:27 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-544912c6f3esm6255218e0c.1.2025.09.02.16.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:07:26 -0700 (PDT)
Date: Tue, 02 Sep 2025 19:07:26 -0400
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
Message-ID: <willemdebruijn.kernel.7e2624ba7462@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-6-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-6-51a03d6411be@debian.org>
Subject: Re: [PATCH 6/7] netpoll: Move find_skb() to netconsole and make it
 static
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
> Complete the SKB pool management refactoring by moving find_skb() from
> netpoll core to netconsole driver, making it a static function.
> 
> This is the final step in removing SKB pool management from the generic
> netpoll infrastructure. With this change:
> 
> 1. Netpoll core is now purely transmission-focused: Contains only
>    the essential netpoll_send_skb() function for low-level packet
>    transmission, with no knowledge of SKB allocation or pool management.
> 
> 2. Complete encapsulation in netconsole: All SKB lifecycle
>    management (allocation, pool handling, packet construction) is now
>    contained within the netconsole driver where it belongs.
> 
> 3. Cleaner API surface: Removes the last SKB management export from
>    netpoll, leaving only zap_completion_queue() as a utility function
>    and netpoll_send_skb() for transmission.
> 
> 4. Better maintainability: Changes to SKB allocation strategies or
>    pool management can now be made entirely within netconsole without
>    affecting the core netpoll infrastructure.
> 
> The find_skb() function is made static since it's now only used within
> netconsole.c for its internal SKB allocation needs.
> 
> This completes the architectural cleanup that separates generic netpoll
> transmission capabilities from console-specific resource management.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
