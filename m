Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C132F743
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854591; cv=none; b=lmpnWwzSZeAU+R4YNd0h3mWZHE9KREytwQ9PnoHvj8UKWhFUr5EJ5O4NQh7d/SO4KIfo+HmgHw1TxRGqZ6eAgauHSfgC+xcFvmcBJ/pWZN4tuhetcJIuWatSC5aCRyabpsr4SpEgBYaUsPv9X83fLFbLQWzRxtrR3tKbUUnm2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854591; c=relaxed/simple;
	bh=HS2jGEZ7zulaUmSWROX+FYgEbo6eNtCYZXo+jqtn2Oo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uC0DMrhzoSs0a591qkwkfHcL5+JnUv75Iieyb1+1dCfoQ1jNl+gc4/DAgXdUO7cSt7OvfIVXODPcNbsABp2VXLGc9H4xAjnFt08RB9JxPnvV+V5Xkd9HoA4TR80giOy/6dERPQXIz4h9wDMEoOQFD7aSvl0wVV7nQhZOlVmupjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXON0J/t; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXON0J/t"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-892196f0471so1977815241.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 16:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756854589; x=1757459389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHJXdbNvbe71VInSbZOxet9v8zdgIHpZX0h74ciegP8=;
        b=NXON0J/tU2lwAugEiOgFhe3UMETnXi6/raUS3oihu+a2c/ZNmJ8/OyS7Pp6rBrORu4
         rnB2hoC/CC87F/1byxhV/bhY/xgZQwjCDhQqqOUqNo2aaANpnqqr9Cd++cR1trahngtp
         ogQjaVoECFZXzAysEErPsLlDhCyUppkcprQmee/2qc2nFcKRpEwdB4BWBxsk5NdGt5JR
         aaRqxER4H125H9Bff7aJjuKPyDZMNRNXlq+5t/YuiHo2OM6+FV3nmkdahzFfjTaFAT/G
         BQm+rNJ01exKfLKgWnkr08br9hyGJJ/W00aTVZWUg5iaFnc5cAKMsw832LAUaH+J8Nc3
         zByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756854589; x=1757459389;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VHJXdbNvbe71VInSbZOxet9v8zdgIHpZX0h74ciegP8=;
        b=GT7dYnyqoeDTktleBoDdB+MbN2txbsULNwAn5ZTdls1/Q/0idFfGuhZDJgoe1WB5NK
         fk1BVf6+LVF8YneFuZ8FpAbbADjbfOE+M6KxuE7fgbZqUBZkAraR5eOVh/fekiCMyVca
         fpZ4m/ZrqChRPEQdec/MocBiDc6MpKZe0iK6t94QKuQDMO/+WAVmXyQGTKL3SW24NL50
         qZSYBPknnRPNflh/t0NUmmHh5eNNWploT469BjBh/LN6gSAUx4PdFdjuqg4CUV1Vt4gj
         CZo8AlIfz6n3tOAt6KroPXQs8RP83gJWcYG5kEJe8B7J1BcsHM0sMR0Q82ylLEBp2P0v
         eraA==
X-Forwarded-Encrypted: i=1; AJvYcCWvps1bHbHkH45Vv/q7wEq0LkYV5J155IZc3+NkegmTDhqSEdvRBZRkHOxeQ+FEWNrHnH+hE7rHidzeXmUfZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHpUoJyq0Q0JaTiNB3vkjk0VWlCQE4CT2BChcvr05o1KACEMkf
	qaxESt5DL5xLY/zAmRiU40SZ6gOC+s+/Fp3OsqlRlPnkukemdkmlqbNE
X-Gm-Gg: ASbGncssNAaIAvjPNRFtCvGNnsE9uwmDcdBnv6TCDbVv0N2j8zCxf4MvebhO9PbuISQ
	IkQdn2XdgM9kfdz1zxvkL4XWxeCd7V4hIoJVbU/XIdZqlqFeoVA8BSk64o3+jUCquDHs1u4OzBf
	24TssYtHI8Wn5VPAs0Wv+V8Imcoe1pO99gzX5CpM4Su/9UdAU9vC2P6xvaY1RrgaakmsAp91Er6
	vx3HyxI/VDe5Q9UPcBcr+UXJSL7oRHTwGHq7YGoRxlkuDjkAjF1RHKI5XKXrneZ++8wJlNWmLEs
	ArF4Mkfh8hg5zXgRILul7Sm2rNohxf1ra+tkLP79J5YSlsoClJEK9IExU/pg6GNgHqLOV63Ijhw
	UeNvLsTF0gqCq+2UfHkDtwjNVkY0ijAo33/2khieqLvDnM8OmLnJTzHJoFp1Mv1K7eqamwUof4N
	m2vezr67ERySU8D3J/Xg8Hk7c=
X-Google-Smtp-Source: AGHT+IHxLuLCKZBNbBTvxy9DB+q5tdYIBT2jIbA238hhbryhI9WewsFJ9qYqpYAQF9Ajvi6zmY1HZA==
X-Received: by 2002:a05:6102:2ac9:b0:529:b446:1743 with SMTP id ada2fe7eead31-52b19a55edfmr4837156137.11.1756854588888;
        Tue, 02 Sep 2025 16:09:48 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-52af235c6b5sm4769566137.17.2025.09.02.16.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:09:48 -0700 (PDT)
Date: Tue, 02 Sep 2025 19:09:47 -0400
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
Message-ID: <willemdebruijn.kernel.3542f359d6270@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-7-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-7-51a03d6411be@debian.org>
Subject: Re: [PATCH 7/7] netpoll: Flush skb_pool as part of netconsole cleanup
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
> Transfer the skb_pool_flush() function from netpoll to netconsole, and
> call it within netpoll_cleanup() to ensure skb pool resources are
> properly released once the device is down.
> 
> The invocation of skb_pool_flush() was removed from netpoll_setup(), as
> the pool is now only managed after successful allocation.
> 
> This complete the move of skb pool management from netpoll to
> netconsole.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
