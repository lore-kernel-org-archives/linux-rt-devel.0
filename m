Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7B330668
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050239; cv=none; b=XiBnw29vJ/4Zd38PgQ27AatWdLDG6EdrBOLqx9ZQwyDhM5Dkc67m/Tx3VG+FLMsnWUbA7zOXOD8YK4N0+esHV0GaiF90dUnIIWyRUcg108lFOrnpYbOFiicfP8czcw8qKDmFysj6i35pYpIj/3UqLbiXSKUSek822RVELVPwH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050239; c=relaxed/simple;
	bh=8Lk1cogg5352nQHgKI1WW/DDJU3qCFewyZmYxMrF1i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXNSYpnirbPNHoaIKJmZPj3TQh37z9NxuT63G9ww0yzyWt9UhbuKUTpsvWbqMnZsMHSeawgbGrMBQ1bEITnDre4qEXBEt670ctGN1RZ/+VZQ09oY/zR2sIIeaI6Put8Xm6JwqNvX34F8f1qFdZNFNOKXQn3PIqV+7OLySuxNQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fUo3KqXW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fUo3KqXW"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-431048c4068so222281f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 01:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766050235; x=1766655035; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=auj72bQKfXEBr2u68dWzZijoBsCuhcqMu/4EXNR4iyc=;
        b=fUo3KqXW00CgUsupE3XGLqCM1pfBKcLFEQX1kf5sl9Dlw7JSEFqNAl2qloCFT684Ba
         IcRIvP3aJYFlW9MVPBQBfda8341WuEHbq+yGQwKeF9DHfGnwqccpFujHVZHTNWxLcQI9
         HnMwzHOzyQes8PE9P+5rXIhEj+bMFA788Q0SBE/TMRopesZ0ydgcjw6y0Yb55kz56I86
         FnkPVuvBJP+zL4CKPrls6B0NdpUblJ0/EuJ9rjzbPGdGOTlF0zTxd8+30U8nsvdYAxEq
         0E+ieIEmhpRwSDmzda3rPc5MMEvGQjJzDPrx8qzPrJSoBoW9TkpgiJEDN2jCMMOK5f5c
         o8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766050235; x=1766655035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auj72bQKfXEBr2u68dWzZijoBsCuhcqMu/4EXNR4iyc=;
        b=Jj2g7930WRSkE+PDtEMr6IqHAMMUx9Ud/G00P/ivx9uGPzU7TYt3Km4LuehPj185o5
         okewnl6JYmfcfnv3/0EA0946WEwlcPuuQELPZQTOszVjq4WV2tC+nEDWNtOeSZFYVExM
         xQc4dl5CF26vRLVZsMgw4Du7S5a6/dph+/wFrWAYrajcKRpO9f+5hvBVvaZyzmvXvWgc
         y9ofmXACcVYHyetwLceMLmrHEXD10fmz6C96mfFRUh/cWWGHbDe6JcaO5/XhzRJwKrT5
         pWJgano8hAQtY80Uog4NgeCfWs4MiC6BZWI3llw0wK2a8HQzH9+BSd3xuoU3AKNxE15G
         rpCw==
X-Forwarded-Encrypted: i=1; AJvYcCVy0yYImTmLPV6fQ9vI0kWg1ox6Yyo8WjBEntwRo9ILmmM1PZ30vUU2ofAj47m5TWIzvibGmV0RYKX/gjbuag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxrdxt/g3ztKe3Tppb3xVJ7ig4/de/zIYDN/LuhYodfv8ngonuR
	E7WYNUs4cuN88ponnKTTYsyi0jgoHaygxK2QHognA70w//504wsewAsum712nzr/gUs=
X-Gm-Gg: AY/fxX7StsSH7QAXRW+mOE0Cy9qSr+ghgnF/h15fRu5Q9P1FT59YvUoFfxS849NWA3o
	5Yx/ensFxc9o+YSCLRBU01An4Titg95q/WGHTKvKeVPZPoIkMg9ktVENWO/RrHJwojj1yFAKux1
	ghvPkIimR9CB8kyhQ/Wq9koi1xjFD4i1pRfWpkMU+NENmsKQJ9SudhbxFiIyKVhvGXB/1bY3kjl
	hL6pTD/PNsjO6DRuqO41Y4a0ewMYHlhfXruhDucJ/idIlgMmt8KMiE1XbYQdAv1n4Yar0JmRLut
	oSpDOBCEQ0+cKHAV1zpjFAHrL/nHD5f3PWO3b6fCpMyTIrO8P5SezFRcSja7rJRH/iQ0+MzpZvI
	KasKMrsnBvcNFEkjyoGm32yJ/E/DSQBymQGrycDq8P15GlOgFjuMXVSh2wtoRDK3NCx6l02HFzU
	Imt064MhA/VZHRvIoqhbxy4tWq
X-Google-Smtp-Source: AGHT+IHyh7gnIimLVB/hVii5bUcInWlX+sJTJLBC1+RURn9zto3ffEvz7ijXdEVgop3qQY9DVJKifQ==
X-Received: by 2002:a05:6000:2407:b0:430:a803:e49f with SMTP id ffacd0b85a97d-432448b7f43mr2778068f8f.15.1766050235424;
        Thu, 18 Dec 2025 01:30:35 -0800 (PST)
Received: from localhost (109-81-80-251.rct.o2.cz. [109.81.80.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324493fe32sm4092572f8f.14.2025.12.18.01.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:30:34 -0800 (PST)
Date: Thu, 18 Dec 2025 10:30:33 +0100
From: Michal Hocko <mhocko@suse.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
	ryan.roberts@arm.com, kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while
 stop_machine()
Message-ID: <aUPJuZINNuNxddRX@tiehlicka>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <20251212161832.2067134-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212161832.2067134-3-yeoreum.yun@arm.com>

On Fri 12-12-25 16:18:32, Yeoreum Yun wrote:
> linear_map_split_to_ptes() and __kpti_install_ng_mappings()
> are called as callback of stop_machine().
> That means these functions context are preemption disabled.
> 
> Unfortunately, under PREEMPT_RT, the pagetable_alloc() or
> __get_free_pages() couldn't be called in this context
> since spin lock that becomes sleepable on RT,
> potentially causing a sleep during page allocation.
> 
> To address this, pagetable_alloc_nolock().

As you cannot tolerate allocation failure and this is pretty much
permanent allocation (AFAIU) why don't you use a static allocation?

-- 
Michal Hocko
SUSE Labs
