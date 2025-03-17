Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81D1A00F0
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Mar 2025 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232887; cv=none; b=a8SXKGgtWlE8uk+HVwDDmxicIJcin4kWVC6bBrD/QLW+laRH81/vD9cjdeL5yJeWVLiHhTQZ4HTeOqL3j3pB4+VYstkH8C6SHie2QUONwykAeueXmYCNYM4iH+m5HED9k/Ys4mSIFfhR/HxOKsHjox8siboI71t50XTfDf2iW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232887; c=relaxed/simple;
	bh=AE7O+HTLc6aGD7Swg7gzHI3sU9vyqgNlA5NhaXp5jb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EK1o5N6LHljHGvArirATnmbvRnQd5dTpPDo66mNprEpeDdz3iCMgZHyoLGUCDCcluo5dHDjYGB9AfQqUINVJwPQuNabYaqNssH6/agvfIV19Y5w8uNySX8XMySGcuPFw6NtauWj4plgl6/iBB5XcUwgt2I5et34wblskh6bfRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5zpsKVD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5zpsKVD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742232884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rcx4jW3bSmWrOin2e+jHJf2gUgkUZibpiqGShvUlvuw=;
	b=O5zpsKVD9hZqhlHhrJDi4RY9zVAp70bHRrcdqfGEmXIda0Ps4P6dL1zyRAZJ4AFuxlOWRA
	QOnUtHbs8jR3nEmhMGlOr3gHuHaFG7CFwL/H4m+6szVEziKZzm4XknXiovygV+5H/5Juoy
	up15teyxMKmJPahBuNSUYrz0Mnz53B0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-UNLSjaCWMyiM1QdRtGxx_w-1; Mon, 17 Mar 2025 13:34:42 -0400
X-MC-Unique: UNLSjaCWMyiM1QdRtGxx_w-1
X-Mimecast-MFC-AGG-ID: UNLSjaCWMyiM1QdRtGxx_w_1742232881
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so14014765e9.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 17 Mar 2025 10:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232881; x=1742837681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rcx4jW3bSmWrOin2e+jHJf2gUgkUZibpiqGShvUlvuw=;
        b=eA5Z8gvnU6mixk95RjXY2iKLfkGPZOGhIwU5BkG5LUzbV3FITlI7clBYQTF47EKPR2
         GYpBa3Bt3Mc92TgGQFPlaG3ReDuopn7PI5CYwNAZvKriTqEO7v8/i+OM0jlT3QEPM6Ig
         RZcwu9nN4xEsqmmoQqNn9eY/PeG8TaMBxC77RSljJJCHd3y/9k4fNgqI7JFVHyrgCiba
         4wFNmimjXJucIzKcmqkVtEBsPlgmUJ48lwMqoqGFBRbUC3TkA2E924oca7k4tirikMWs
         t3XCiuw9sxV/rktX1zfUrBuE8UxPe6LVQym0+1g48y/IL2nHZ1LkxI5JoJLQSiv+3IjX
         k/dg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Z3AbwkZ8TQvI4FkP6MsqUnWjwvyNOPmW7ZmA8JTgAdYH+mUyHVoJQyggWri8Kj7CR2hEAhOinnLmDIab/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwFPtckUmRwHxfv/VMRTCMlGDWD2onghqeFR/2X3uQKUO4BrO5
	7bC230cE2OEZ+9MzG5sa65FECApJjrT+XTxKUOg85N7++zuZu67O4U5tG5V5O40fi3xaV7/++rt
	OCTxets3VOF6zd7X0gHFkzNTQhaam7GQEp8Z2PArGVu+Lrj4duXLNfeKlgNsOcD2uKIWKa34z
X-Gm-Gg: ASbGncuqV0PdVOfbf/bOUAIFkgnkNRLsMl/F9xHjaYuIo/KCnqX2pLwQADfbcMS4/Qy
	SyCGkJPWFXA4vQ430srsCxbnkXfKivsDcLXQDBnQc77UhLWki6tHuCX+gYhqIWW/L92xa7Gg+30
	hPVKOsktxW5ghxdreHIruZUWof1nhrP6NAkF8aE5JOUhkc1vFSdHnYLISercxVbqab5LEUOpm91
	w8CyrJq6QTui5nmIif9nRyHv9KZQkJns7lTo1rvP/yzhduiRxMPaujjE8NQOTMKEw+pRXF9RtPZ
	KfFjEioJ4qSah6vhNToURC2DmduNDrzkF+4gQNlJDKdQgg==
X-Received: by 2002:a5d:64cc:0:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3971f9e798cmr15340432f8f.54.1742232881185;
        Mon, 17 Mar 2025 10:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH07D2ZOpfJBFzw6dlnkXuEvZ1zAjKVlbD1ulYGuVlRyj1HqmH+xeyba+sV8D+fEP+JRkYLHg==
X-Received: by 2002:a5d:64cc:0:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3971f9e798cmr15340406f8f.54.1742232880843;
        Mon, 17 Mar 2025 10:34:40 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e2d6sm110075705e9.38.2025.03.17.10.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:34:39 -0700 (PDT)
Message-ID: <0c5a60bd-ceaa-42f1-8088-b1e38f36157b@redhat.com>
Date: Mon, 17 Mar 2025 18:34:38 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/18] openvswitch: Merge three per-CPU
 structures into one.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Pravin B Shelar <pshelar@ovn.org>, dev@openvswitch.org
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-11-bigeasy@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250309144653.825351-11-bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CGKWiDwIS53jpDl74OEjMkkbXrK1loQLThFnsJ-hU9o_1742232881
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 3:46 PM, Sebastian Andrzej Siewior wrote:
> exec_actions_level is a per-CPU integer allocated at compile time.
> action_fifos and flow_keys are per-CPU pointer and have their data
> allocated at module init time.
> There is no gain in splitting it, once the module is allocated, the
> structures are allocated.
> 
> Merge the three per-CPU variables into ovs_action, adapt callers.
> 
> Cc: Pravin B Shelar <pshelar@ovn.org>
> Cc: dev@openvswitch.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/openvswitch/actions.c  | 49 +++++++++++++-------------------------
>  net/openvswitch/datapath.c |  9 +------
>  net/openvswitch/datapath.h |  3 ---
>  3 files changed, 17 insertions(+), 44 deletions(-)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 704c858cf2093..322ca7b30c3bc 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -78,17 +78,22 @@ struct action_flow_keys {
>  	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
>  };
>  
> -static struct action_fifo __percpu *action_fifos;
> -static struct action_flow_keys __percpu *flow_keys;
> -static DEFINE_PER_CPU(int, exec_actions_level);
> +struct ovs_action {
> +	struct action_fifo action_fifos;
> +	struct action_flow_keys flow_keys;
> +	int exec_level;
> +};

I have the feeling this is not a very good name, as 'OVS action' has a
quite specific meaning, not really matched here.

Also more OVS people, as Pravin is not really active anymore.

Thanks,

Paolo

