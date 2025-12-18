Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5891A8F84
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060739; cv=none; b=pcXJSX3/ZIexpxF0AC7Tkkc/WzSC0d81p+DDZVtEkYzB20hn07oMs4vmxPPm46XoLN80p403yrzA1V+v0qLyy6E/VuBKjaws5GluTH5I+Q34tcc8Kev0F+IH60OOD8yModFTOYtp/OC4M99UUgDinHkjxs3erkfR9jyNL8amGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060739; c=relaxed/simple;
	bh=g446pCxbogOPmsgxR1U2hiPWo0yTiw4jPgm7h5n4srk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXVy7o00px/FRI6zPo+Ge14ujrJX6HQ1D5PgqcBf6hpiQ52cefogmzDWQ3oM18dyVfERoBn4/bB4BJNBP5w6IfQppRL4CRw1/y37L8yDMYBfg5eaHBu4hqzWQMAk6fqkbNLK5fSbXN30Om9o9TPouiZAxyHumAqdbtFCwEbMw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnRTC42z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnRTC42z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766060735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBDR/C8OIycMQnw+mvtf+lZVrY6YnjRU6cUOlstz+PE=;
	b=TnRTC42z1tkYLpaXlhOzFnLtqKoO0pHBJKepo1cbA/m1EPdULCam8uLUKxF5yJEYPHN2Q7
	Cxm2nyp8cNcZxXax42mCweNb78GoYdDsBggoGouOBbW1InS67p9BUhZKj/k+OJCUO19OBT
	5M6ZWcHwwRt6bkIrIyf5JLZvpelz+DE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-bopsTBzEOzm-QEC2ijOElQ-1; Thu, 18 Dec 2025 07:25:34 -0500
X-MC-Unique: bopsTBzEOzm-QEC2ijOElQ-1
X-Mimecast-MFC-AGG-ID: bopsTBzEOzm-QEC2ijOElQ_1766060733
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42fd46385c0so291162f8f.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 04:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060733; x=1766665533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBDR/C8OIycMQnw+mvtf+lZVrY6YnjRU6cUOlstz+PE=;
        b=ceoSi1NrF3T17xbL4dhrxClMDqQ6hvf7q8omjbqgrLG7V3jkuuvNQSwGwvwULgk1GU
         u+7NYGoFBBHJzgpK1CTW4qCHqGHHZWE/EHZRLgXNqU2yODxQayDGfsu6y9wg3cOIhM74
         BBBC7x3GkX2dGZYvBZktPFKUL5MtfHJdJWPIYuphDsg9Gizv+1tRj4xhaD0QE13zVzvL
         WU+HtpEfctSs/OyobWnrPmQqQIfhnYfGYLPESI3F5flk4qvUhOKrCcKzLU0el1bz2iWv
         apxUfFQpFwD09i7IW6T8EChj5/C1ukrIdCxq7LO03mkL1RWqN/BJfD8oDijAXmWp8PFo
         t6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWHiiE4L4plSWWmMgpjAcgXHNr7zx519EiDu/PALE+RK95kfivALXJeAuLf0ZxLlP6pkWXbsfQL92pOcaNYfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSc64haSPQweQMzNLeBOFQFOl4k8yW7nLuhVna8vdTz9akjEbN
	4Q1gz7FaJRPEwksPf9AXFpP6ACfWAtkMztWCLavbP3lhjki3GNKPf9Q/DCnN1GRtmOKqww0Jl0u
	aLWNYN9fwaKIb7QBl5rMwqCogELCnq71cwiVaXL588kbXu2fizBA+ssuvMhLtw+voq6M8
X-Gm-Gg: AY/fxX6pjuZqot+BBblY2DB2Q4xk6Zb96adPKwzvEcw6ddbdDqRZ69m1NsX+lf6rBVm
	KE66AtLAJtM4wFQCu6ERrFb4li9crH/yvHpRIYtKuNdJN8jN8VsY6J31ATVxLZNS/uGeV4z/bz6
	9DCs1m9ZiMJ90+buarlUrg89DQz1AxjYopW87oAWpWmLq18cBlNoR5Lzb8Y++nPTAkPieUA3boJ
	ZCYO54QqIGozMyfNnfKe4T8tVt9XQYfgGSxJBdm9f3wU/GIqhRyfNxWmk7hoO/v46jScJycYH6h
	xBSUnxpdV/NCpb+tr3+R+rDlwsJZ0bqm4xfSmKg60pCGFWYon9u/rN9DPEMnD3iKVLNi/dUNyov
	BkN+6VTNEZTXB4A==
X-Received: by 2002:a05:600c:45c9:b0:47a:8154:33e3 with SMTP id 5b1f17b1804b1-47a8f90f951mr208747695e9.28.1766060733397;
        Thu, 18 Dec 2025 04:25:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbohIX9qIDX4l8X76X4mdFhyfXapGsjSNeRZsdrYz2q5Lor1FPIikVN63HsWMIrEqKvhUx/g==
X-Received: by 2002:a05:600c:45c9:b0:47a:8154:33e3 with SMTP id 5b1f17b1804b1-47a8f90f951mr208747385e9.28.1766060732987;
        Thu, 18 Dec 2025 04:25:32 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm4745537f8f.40.2025.12.18.04.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 04:25:32 -0800 (PST)
Message-ID: <280b18c6-2348-426f-a1b1-8c17d229c21c@redhat.com>
Date: Thu, 18 Dec 2025 13:25:31 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] ipv6: fix a BUG in rt6_get_pcpu_route() under
 PREEMPT_RT
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20251209124805.379112-1-jiayuan.chen@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251209124805.379112-1-jiayuan.chen@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LLjFx9RO01bGh49e5oa1FoCJbNclDmoswBalEtSYnYk_1766060733
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/25 1:48 PM, Jiayuan Chen wrote:
> @@ -2299,11 +2308,13 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
>  	} else {
>  		/* Get a percpu copy */
>  		local_bh_disable();
> +		migrate_disable();
>  		rt = rt6_get_pcpu_route(&res);
>  
>  		if (!rt)
>  			rt = rt6_make_pcpu_route(net, &res);
>  
> +		migrate_enable();

AFAICS, this part is not needed: local_bh_disable() ensures migrating is
already disabled, if !CONFIG_PREEMPT_RT_NEEDS_BH_LOCK or preemption is
disabled, when CONFIG_PREEMPT_RT_NEEDS_BH_LOCK==y

Side note: this patch looks suitable for the 'net' tree, please change
the subj prefix accordingly in the next revision.

Cheers,

Paolo

