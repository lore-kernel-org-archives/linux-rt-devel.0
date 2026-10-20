Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497506;
	b=yGHMPDC29TjM/7ifW3a5M1hOTGa7Ntpe4KgoV+JJApfr3eRZ/Hk/9MPtVzSDfjOggFFk
	 IHRNQYPBCqNvJzC3OohCmC8TcHOly6EBMORTIbjj+91d/hK089PcEIzi/5pT74pQMDd4y
	 QI/SkJACpoJiec2DSIPbe8bcG5AsDUq7yLfo94Vj6QuQmvY/+VZHuZ6aIXTxkXB4bS2+T
	 QKz5raaLxG0YHUvb4f0yVTXqcDu3pvBXyl5X98OdOR+CyMCNRPT8G7OMzQKY1HNbEhRzL
	 xAS4AZ2cjzhFKaQVDHJuq/lFMVoZjmzP3FXno/XlFmbpynQyLlDk8+Amn/9HEc1Yd3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497506;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3cSxXqVZINLaJAxubbW3o8shpEbL0tUTG34iYCI9EGw=;
	b=EpY9KBYIscK2QBS+Ef2I8OII84CfVsjFhwvikdhZ0WJKA2Ed/HSGsrHOFgJv/I6jOZIO
	 XMoorDTw4kWXFWvY5Ljvp/JIRKUIRfDRwNtMETUljGXAuIU/BDjzAvPdIpjOsvnnNEQfF
	 Af7+b4q5FlF0PvI1wND767Lm3ZU5hV+D3LMw1NI4A9U1WT3v6dXLoExxtWY41NDxLyX8K
	 t4vLZMk2EhAaQpcV3N9fIyPpcJTm8LSAcdJnAXerPUU7hGRPPMnIQ4oiG72/P5Oc41bd4
	 32UR86LeBcaoSJepO3+zKPcBIEn8Nq0e8dNZeE6ab5GqXYGyH9+/VCadf2gBfFkm3IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPCsoNHu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC360A3802;
	Tue, 20 Oct 2026 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPCsoNHu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E243A1F000CE;
	Tue, 20 Oct 2026 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497506;
	bh=3cSxXqVZINLaJAxubbW3o8shpEbL0tUTG34iYCI9EGw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mPCsoNHu8NkqOtKwnTL59BoMcQ5VHuIimMsCxFr+2x8NLW6DT0PKYBInJw/kCCBIZ
	 98tOwk6/2FuDpBdbxok4rgu5JRvjh3To/UB1124Z69O1SbHSZ5pI8VHYhAa2I5fIVI
	 cJTOFBqwzPmqXfXtsQbsDYNb2xBGTci7xrZuP+fulKZpdHW6Sw6L7KbYaDBybbfWIZ
	 6HFKVLa2sYKAWwfwjINzRyTuNfkVMI4muZJoMekMMdrmgKG2aSS84ZytaEvbqUARB/
	 usl94ajGSPaGzmkEgbf7prrhOaspifxvXDEs3DxcalPRK1NObZuo0vm46Eg7nv9utB
	 zfSWb8qLEm7Mw==
Subject: Re: [PATCH net-next v3 8/8] net: xilinx: tsn: deliver endpoint RX
 frames to DSA user ports
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Tue, 20 Oct 2026 11:58:24 +0000
Message-ID: <179249750444.3135.1692275587478159303@kernel.org>
In-Reply-To: <20261016-patches_v2_external-v3-8-e33d3960ca1e@amd.com>
References: <20261016-patches_v2_external-v3-8-e33d3960ca1e@amd.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new RX demux in ep_dma_rx_cb()
  (drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c) relies on a DSA…

--

net: xilinx: tsn: deliver endpoint RX frames to DSA user ports

At probe time this commit allocates one METADATA_HW_PORT_MUX metadata dst
for each of the two MAC ports. In ep_dma_rx_cb() it then attaches the
matching dst to each RX frame based on its TUSER port_id, gated on
netdev_uses_dsa(), so DSA can deliver the frame to its swpN user port.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index bd8cd504cefb4..5103a3b4b018a 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -302,6 +311,10 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  	}
>  
>  	skb_put(skb, rx_len);
> +	if (netdev_uses_dsa(ndev)) {
> +		dst_hold(&ep->port_md[port_id]->dst);
> +		skb_dst_set(skb, &ep->port_md[port_id]->dst);
> +	}

[Severity: Low]
Can this branch be reached at all with the tree as submitted?

As far as I can tell, nothing under drivers/net/dsa/ binds
"xlnx,tsn-switch", and net/dsa/ has no TSN tagger. The only references
are the binding in xlnx,tsn-endpoint-ethernet-mac.yaml and this Kconfig
help text:

    The three-port switch is supported by the companion DSA driver.

Without that driver, nothing sets dsa_ptr on this netdev, so
netdev_uses_dsa() is always false here. That leaves three pieces of dead
code for now: this branch, the port_md[] allocation in
xlnx_tsn_ep_probe(), and ep_free_port_md(). It also means RX delivery to
swp1/swp2 can't be tested from this tree.

Will the companion DSA driver be posted along with this series?

The commit message also says:

    guarded by netdev_uses_dsa() so it runs only while a switch is bound
    as the conduit.

netdev_uses_dsa() checks a bit more than that:

include/net/dsa.h:netdev_uses_dsa() {
    ...
	return dev->dsa_ptr && dev->dsa_ptr->rcv;
    ...
}

dsa_port_set_tag_protocol() copies cpu_dp->rcv directly from the
tagger's ops.

Every frame accepted here carries a METADATA_HW_PORT_MUX dst, so
dsa_switch_rcv() always takes the md_dst branch and never calls
cpu_dp->rcv. The tagger still has to provide a non-NULL .rcv, though,
or this code never runs.

With a tagger that has no .rcv, such as none_ops in net/dsa/tag_none.c,
every frame would quietly stay on the conduit eth%d. tag_none.c warns
against using it for new switches, so this mainly applies to whatever
tagger the companion driver adds.

Could the commit message, or a comment here, say that the tagger must
provide an .rcv callback, even though it won't be called for these
frames?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-patches_v2_external-v3-0-e33d3960ca1e%40amd.com
