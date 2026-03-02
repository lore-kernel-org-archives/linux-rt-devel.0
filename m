Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA22374179
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471882; cv=none; b=GDfBGZUDu4cS7tGClWbdY5CCHyVEWwxxJyNMUDD9pYgs1NbByz/BzV0/sjy2eWxH/QQ0YBTRXmjtGgS2Ysj9UTAH7+G6IE1xSIeA6fFlsQoh6CwwkvPKTl3HqBOUCDk+j6RpNISOVN8fAh/KreaV1ydB9su00ogp8BITxDynaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471882; c=relaxed/simple;
	bh=D12lC4csJQFYfaVnrXcBeKcl/WifRKhBxfOY/S1dNPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql/ItqlU8QJXzK+giqyX4IkCmEVD1zCfRYlzV8l9TszJfKZbr1hilG/4ABKPLFItyO2WaXmh2qLvfzNUP8se4UK6MQ7lZnjOESeRFkP5PDR6DaGnb2S1ZlqIGUnDZSnk/aX04Tc0coJZS2ZKjkmb+tSqh+XbtF7XSgcrg7hOvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=DuJlCP4/; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="DuJlCP4/"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899e43ae2e1so16706246d6.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Mar 2026 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772471878; x=1773076678; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=km3KT83x/z2meRdGO0nHs+kZ8jQBopdFLi43GSOrfRU=;
        b=DuJlCP4/DjnlOeXNNemPCoH3RtMbDg/wwoubl2kXYttBIiZBhmGzpCrHFqqhaAAAZU
         6lbXgJFdxQ3RSdWojqOr7XjJVKGvDRdzTEX+pf6QJ9tTfMpayKGWQ2XDlji4ZgSETTgd
         k0eKN+JQKhJ0enlD+pMcphNhA7ULDU5o0Ofgt+8iSDOC9ltoqyUZYTDiuV0AYkxeiI44
         JBpdfSltmeAOqEwFf5Zk3ADFtDDaX2iCpLMX3EH8P02PfL1RNh+grhALA5zSKsTeko4M
         aFjTxyDtp8F/BkJ08A9KDEos88ZwMDNsATaQepbT/Z0oHrQtSGKcKQXKzIGhbInHiiPi
         0Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772471878; x=1773076678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=km3KT83x/z2meRdGO0nHs+kZ8jQBopdFLi43GSOrfRU=;
        b=XeyzH6Of/57RGiy6XA2bhFAjWJFpSiTXjyQm2F63DA6hKmEOf7qDawsB52bOX2iTrg
         6swBJ2O82vM6wnhzBjHTTSNN4rGUMVVgZJHgV1kFxA2kk/sOxe5iYYion6vLBOWRznSJ
         dEqRu7d0AmvlpJ+o5F+OLYxYkWGxoqFDYtAKH3EVl9qAzNatwpgrLrEe8PbOOPBCjuWO
         THtizDVNBZzja8m2afEllwbju96cZOOaEJ/431llKvKZ1s3LMJVU+yExIZwhFIj+y9cx
         Z9GjRQar6xqJywA360QRGdCeLk1uA88TYysHAoEafvVosDHwMdk1HBbAP5NfV+FYE3SP
         nFUA==
X-Forwarded-Encrypted: i=1; AJvYcCWJzJQka/7I4xJOsG6NJ2cdYo/lBT7dgG1TCrP69S/v4p7khWDh72n3p2HqIEGF+ybxA6nVEPcCzsBAm0HK6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbFWA6Q/RUgnoGVvuwdsA2E/3GePXnwXzzJQCK/OKVTcV9YXJ5
	cYkBx5Xo/XslmueAoz20i+53JXkSxlqKuf5cX5Tlsgal7CANjFapYOWsMAEke1l3L28=
X-Gm-Gg: ATEYQzz5uZ8JyjCyH6KpgeRV/A7hRfVG94f8SI3tBdnFbhp4M8mjS+K6evp5qyytX5E
	AT2qMZUc0PJXAzfVPHGqzdMuP8E1dTiw9yMk2pqsUCkmbfdEXrZlkA0DMEOO9RilMQYzAXQJfGh
	dpDlXmrjzRyW/xjsuCmF9inDM+IQbRC6r+lMjEzOR4kb6VTYzAyv0fMvA+OkAIFvFChLnRVAE/q
	1OFhkdr8m2h/7d5m9BRtHT9E7I2y1GG/il21ySVk9o5t/rYhId5i7msi4Mu6U/dmxykFNpW0TKj
	5mq91yROZyRSuY9CDJB+0ByidgFaWTsOAAAa02pyfqgfcQUduMVQUiVmi4061rnz2xVXjh1RYBW
	N/aRRBTwVIR44V5twpx7aHtmwIQBAEA/TCvjWwCarquxPDMBRz2XKPYsHl74u982NCkS6X2hHoW
	q+v0xl+LmW9H8WTbgp4KGjGw==
X-Received: by 2002:a05:622a:288:b0:4ee:3ece:a652 with SMTP id d75a77b69052e-5075296b572mr152534691cf.42.1772471878480;
        Mon, 02 Mar 2026 09:17:58 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ad8f8bsm113862031cf.27.2026.03.02.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:17:57 -0800 (PST)
Date: Mon, 2 Mar 2026 12:17:56 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Matthew Wilcox <willy@infradead.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/3] mm/page_alloc: remove IRQ saving/restoring from pcp
 locking
Message-ID: <aaXGRMaW-tZGf-Wa@cmpxchg.org>
References: <20260227-b4-pcp-locking-cleanup-v1-0-f7e22e603447@kernel.org>
 <20260227-b4-pcp-locking-cleanup-v1-2-f7e22e603447@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-b4-pcp-locking-cleanup-v1-2-f7e22e603447@kernel.org>

On Fri, Feb 27, 2026 at 06:07:59PM +0100, Vlastimil Babka wrote:
> Effectively revert commit 038a102535eb ("mm/page_alloc: prevent pcp
> corruption with SMP=n"). The original problem is now avoided by
> pcp_spin_trylock() always failing on CONFIG_SMP=n, so we do not need to
> disable IRQs anymore.
> 
> It's not a complete revert, because keeping the pcp_spin_(un)lock()
> wrappers is useful. Rename them from _maybe_irqsave/restore to _nopin.
> The difference from pcp_spin_trylock()/pcp_spin_unlock() is that the
> _nopin variants don't perform pcpu_task_pin/unpin().
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
