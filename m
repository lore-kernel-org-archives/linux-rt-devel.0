Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344535;
	b=xHXWoJEqeUqkWKeuPVljDcgoySVUbKMS/VPqp7TmCXvN8c/euQdrfrbbdrDfAwDQ3UFv
	 +zZEfuL58HXdcVtDidQCy43vjnKQSXZMGWmKBH4ifv0osXNe5TgSBAF+MnHRclIV4RS6k
	 qpxG+aulJDgcrgE9XNMVxN8HgY4d7kXuBLQSxXYI9IxFzjm2H7tHTLcS4m6zRvFhv/z4b
	 MlP+V9+UR36o/wYOeRglxLc9UmRYIr8oaJ2zR3lhSTuKm/OFYvAuzVlMT/tvey/PDFXBj
	 Tve5ZAzbT4JZtI82w+VdSfIefbABO5B9igP4Jg/iRzIclj713N+FBi68F9vB+Pwrm5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LyTvhcJtY/hqbJYI4KH/+07DZKBe5dmpcgqrAQPdyX8=;
	b=BgZx0PUx7lYudB1xysI3r5R7X3BF+uvnRVO/BjnnEeORfQkxTExoWqLXDDI1ZRXA8edt
	 jhGcCKcx+LhZkCXhiCCfa6VBzb5VjFcC6L/xtOqyXi2lN05Hfra8RpOLdWN1uVbvRM15d
	 YuLGs3mXjjTYFecqE8JfnCQGXWXyAe/J21ouVOC2mdHbNlN1PCdUId8+WfcV5JO44r5cZ
	 7CYegIxd2X4eY7M6wc+8Qel/xd9GKX+dki+dn9L0nT4irRFUTpMCuPNjg6l8LauS0dFVd
	 NDZ1p/3PZphd0AGiAFR3Wh4fAlYxWVZfZfhYW+I+eEv5NJG7Oromb8w4bhm9dJvb0sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=oc3iDjOk;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2F606A330
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 21:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF2F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=oc3iDjOk
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso4702956eec.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 13:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344534; x=1794949334; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LyTvhcJtY/hqbJYI4KH/+07DZKBe5dmpcgqrAQPdyX8=;
        b=oc3iDjOkdHd/F6OcGSe5/emB8Zy1QjzNHpGRFgs9oQ1QLRZ1gJct+oMb7kBzb/400F
         BgNdWn/HOsb+lY+1YlVNYzdm6refKhNlbBT0e2DYYPmwr5574Hr6ll8oZdefz/b92lx7
         lY3wpAICpCM3vJMPTqa8E/w9Lo/Isk1gaVEG24OOJgedCwvBOTedcpDiptoUuKMr3d60
         gKWriHtEUZBKmpC7F7SF4BTqll7xpIHhkXUPShiLhXxga3HE/lBU+Oqw/mI4r2+5DkCx
         OCKBwR3nrttwvZ9mNqt9/KZhrIO0UZn7+NovoR0ktSJCAauXv0SzO3yxaUW+hPlz37DD
         uSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344534; x=1794949334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LyTvhcJtY/hqbJYI4KH/+07DZKBe5dmpcgqrAQPdyX8=;
        b=cNPrTOE8oN3hwRXZy3h++h0heMxklDObRM1k9BQg1VLderbJUWG2mcIVl8E4tfdtAf
         ZTm9cw/qR+KhoU3p6VZkkCuensMlau1OULqazElVqIFGY9eBHaWX1uYCQRzJT+BiBMpx
         URG8ujHoa2hxUB3ihlQXMFcVARC+sYETtZ/0KkM6XGkiNwHYm65D0Uaff0cZKWFqedm+
         8Bz4QH1DJBaxIvqbJFx9Kcz6epKjAHXPQ78KARiPN8y+RjdR7FbNfuDviAAy2BLE2kxv
         y5JE25iFSuhatMd/hRt/5kU3lPb4tJ21i5Ju7ChgpMPQ5FbDYNpyP1DxsvTu7fLiqtdx
         wyYg==
X-Forwarded-Encrypted: i=1; AL+hErHvXa4M2JxTTHGlQpZKWRIPaFmPBUJ4tAo6knqasDjHK6yLx7MVx/xZIJc2+CgMdU5u2n2Nfj8Nilkv+Fji1Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z85SpnnS/e0qVVSEjOTKET6gVdCmv6asD03pMFaGnZKaZJlEwZB
	73b0SeuLb7tCWGhdOah5Piv+wIw+Sr2c6oYSlbguuaXaE6GDtMpYYRZWhP/Jsa/g1yU=
X-Gm-Gg: AYBFou3QYW6e0WI89utIF+uoKeApE49bTlTjwXg96+l2YHMmLIkD630PidShXLogqrr
	aHAHyn82Otw0t2ZQVA8ASyhEOD2Q6unM7Cq7p5c43fS9mrf7kgsZ8VVvH2NraCCC/VD6WFxx9DC
	hyGqSAECwjiHr6tMwZNmUr6TzOpRE0LVorBRjFpTJ6Quyao2VNcqz7/CpZFtlwxjLP2Czj4VNxf
	KVtzlvqbq30usGSkuvnNlMx2fzJ1XPLjik0Ow63SuuYHKPIGegh8asN//ttpsYEmmVo1VYDWkKG
	CqbmDZRs5Ti8wy36F2aT2NpjzUMW29uFm/WsQ0+a1XAjg0QfaZO9fByrGRPwDfoOJHgFfjWexu/
	36gt6AUOHx5cqHg7E3MJ88KFiKkAgaIX5ep+MmVKtlyF0xqeePsfV5JovWIK7WHbqavnK2hJ9qq
	7bvp0LdZc0KE7NDsn979NmCkkeko5nT8geaPrbM/4pb9TMoRxnvg5JAaDrx9YoBQJPtqJju1oKJ
	CCOELONL+t9Xvdoz4l0KzfkCvBp/vRCPjtUhRIdTmwQT9M3zA0guOy9oadBgGAAwEd6SvxcaicA
	xzaEUsn/GfAMjg8aXNIHlJMYtTx0o9X0w8TSTjwx0qsF23rp2AZaY/mppgtAVTfXBJycAYU=
X-Received: by 2002:a05:7022:b052:20b0:17b:fea8:1425 with SMTP id a92af1059eb24-1b3c032fc24mr87106c88.30.1794344533792;
        Tue, 10 Nov 2026 13:02:13 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4ecccsm7919469c88.13.2026.11.10.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:02:13 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v6 0/6] amt: relay tunnel lifetime, validation and request-path hardening
Date: Tue, 10 Nov 2026 21:02:01 +0000
Message-ID: <20261110210211.110139-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107004935.2627329-1-omar@blockcast.net>
References: <20261107004935.2627329-1-omar@blockcast.net>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please drop v6. Patch 2/6 still lets deleted groups pile up on the GC
list without bound between periodic runs, the parked-group pinning
Sashiko found in v5 1/5 (now v6 2/6). 6/6 also needs its per-source cap
derived from max_tunnels and its changelog to state the MAC expiry,
replay window and key seeding changes, and 1/6-3/6 need corrected or
added Fixes tags. v7 follows.

pw-bot: cr
