Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912374;
	b=YI4kv7ldPDptBCroNZhyXDy5n86ognliAXq1pvGVo7+xRsEu1m0V0f8/E/LYg18g7Eco
	 ZhBccwS/gi0+eCYokvawwkiWd8ngHlNUpE6DUt2rjAF/6F711CSL3AguzHCDGRGhwxqye
	 bmRynnkC2GQ3pOI+6lb/i0QlgiMOJPdpm+XIzipdOBWRqDCSgEvtlo7thv0NE2tdNMbiv
	 HEoumPWfDMryjPGLqMpkiO+DlakYzOBIHbJExEa2I+e8lXmHjSMZvXV4sTSiO0/3kHUri
	 KedeG3lQMHg+al+kYBBbsgSwN6BXZDhGvEeDjqd3Hn7qCE/bNRP98idCrRJSp7AzmqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IHCAtEbK0J9hRVIPP4NnqQaZSVyTmUf+eCu8wYP9Kek=;
	b=zdfbq/oMn/xXbxAnmboTvl2ggDNODzp96T0kEJrfZj2KTU6eUE+FuHw/4ee7jVPzFBe2
	 yLr3husxp6ws8o2NanQlzabeJzcmMq/RMQlqIXamiy3XB+lP8hWjApRIHZYOZHNMmr0WS
	 GJB147n0PsrKICXeaRwSXSyPBRuc8TNgF6/ne7Dk6/POPXGTk5Tcm/L/jclSp70sVxgH9
	 GvPPWuskDPCZB6BstFu6dDmkE4ge77ZXnRUFEcMBAhDBQhNh86m8SKlFqrX6Lww+uNfBO
	 Ly6yiJkzAPX3TwQATogNHcgdDqkoWjDxrYNXq8C7pnXielETe5NcWeEenuzKNN+zwCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVICxrAb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02169606A326;
	Thu,  5 Nov 2026 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVICxrAb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624391F008A1;
	Thu,  5 Nov 2026 20:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912373;
	bh=IHCAtEbK0J9hRVIPP4NnqQaZSVyTmUf+eCu8wYP9Kek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PVICxrAbU5XwYKEo5oNt9ZWTGzRogn07pVMbmfydMLZg+bS3zeEGG9TVjIAFVqou3
	 TzbKPykCrbqdD3ADLP95XTgxUambVW7MCdoiEPvargsBa/AzmjBhNGYm1iCMKx4dQD
	 i4OOFRr5uMCmovM8Z3nHk5DibonRKQCI40AqEDNV0N4i014tzjNWI+OvE9trrOPuhp
	 3Km2XKfr4f8CDtY4ycfCPuet/nwk0nQwST3ueVe/Wv6Z4ACf8Vj3Q8uoq55OY6V/Hr
	 D1XQ0bosL7ypfejALojqRO0aimBPTtOTnRNeqKJxoPbZouqa+TXzke/v61lTbHH05B
	 QVJlZkTR7KJeA==
Message-ID: <sashiko-outbox-200172@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] spi: cadence: recover the controller after a failed
 transfer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Behn" <mario.behn@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261105203703.979067-1-mario.behn@gmail.com>
References: <20261105203703.979067-1-mario.behn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:59:32 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] spi: cadence: unreset speed_hz in cdns_spi_handle_err() runs bus a=
t max clk
- [High] spi: cadence: missing IRQ sync in cdns_spi_handle_err() causes buf=
fer UAF
- [Medium] spi: cadence: unreset CDNS_SPI_THLD in cdns_spi_handle_err() bre=
aks target
--

commit ac57da57c19b61a2d1f323d2cee0fc683cff3b77
Author: Mario Behn <mario.behn@gmail.com>

spi: cadence: recover the controller after a failed transfer

This commit adds a handle_err callback to the Cadence spi controller driver
to mask interrupts, drain stale bytes from the receive fifo, and reinitiali=
ze
the controller hardware after a transfer times out or fails.

> diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
> index 50ef3a7871c22..474ce14a59b3e 100644
> --- a/drivers/spi/spi-cadence.c
> +++ b/drivers/spi/spi-cadence.c
> @@ -542,6 +542,30 @@ static int cdns_transfer_one(struct spi_controller *=
ctlr,
>  	return transfer->len;
>  }
> =20
> +/**
> + * cdns_spi_handle_err - Recover the controller after a failed transfer
> + * @ctlr:	Pointer to the spi_controller structure
> + * @msg:	Pointer to the spi_message that failed
> + *
> + * A transfer that timed out leaves the bytes it clocked in sitting in t=
he
> + * RX FIFO, because the interrupt that reads them did not run in time and
> + * the host path never drains the FIFO between transfers.  Every later
> + * transfer would then read those stale bytes first and return shifted
> + * data.  Mask the interrupts, drop the stale bytes and bring the
> + * controller back to its initial state; the next message sets the clock
> + * and the chip select again on its way through transfer_one.
> + */
> +static void cdns_spi_handle_err(struct spi_controller *ctlr,
> +				struct spi_message *msg)
> +{
> +	struct cdns_spi *xspi =3D spi_controller_get_devdata(ctlr);
> +
> +	cdns_spi_write(xspi, CDNS_SPI_IDR, CDNS_SPI_IXR_ALL);
> +	xspi->tx_bytes =3D 0;
> +	xspi->rx_bytes =3D 0;

[Severity: High]
Can cdns_spi_handle_err() race with an in-flight or already-woken
cdns_spi_irq() handler when a transfer times out in spi_transfer_wait()?

In drivers/spi/spi-cadence.c, cdns_spi_probe() registers cdns_spi_irq() via
devm_request_irq() with flags set to 0, which runs as a forced threaded
handler on preempt-rt or concurrently on another processor. Writing to
CDNS_SPI_IDR masks peripheral interrupt generation, but cdns_spi_handle_err=
()
does not synchronize with the irq handler, nor does it clear xspi->rxbuf or
xspi->txbuf before spi_transfer_one_message() finalizes the message and the
caller frees transfer->rx_buf and transfer->tx_buf.

If cdns_spi_irq() is already running=E2=80=94for example, across the udelay=
(10) call
or inside cdns_spi_process_fifo() with local ntx and nrx counts=E2=80=94cou=
ld it read
or write freed transfer buffers via cdns_spi_reader() and cdns_spi_writer(),
or race with cdns_spi_init_hw() while accessing hardware fifos?

In addition, cdns_spi_irq() reads raw status bits without masking against
CDNS_SPI_IMR:

drivers/spi/spi-cadence.c:cdns_spi_irq() {
	intr_status =3D cdns_spi_read(xspi, CDNS_SPI_ISR);
	cdns_spi_write(xspi, CDNS_SPI_ISR, intr_status);
	...
	} else if (intr_status & CDNS_SPI_IXR_TXOW) {
		...
		if (xspi->tx_bytes) {
			cdns_spi_process_fifo(ctlr, xspi, trans_cnt, trans_cnt);
		} else {
			udelay(10);
			cdns_spi_process_fifo(ctlr, xspi, 0, trans_cnt);
			cdns_spi_write(xspi, CDNS_SPI_IDR,
				       CDNS_SPI_IXR_DEFAULT);
			spi_finalize_current_transfer(ctlr);
		}
}

Because cdns_spi_init_hw() re-enables the controller (CDNS_SPI_ER_ENABLE)
with an empty transmit fifo, CDNS_SPI_IXR_TXOW becomes set in CDNS_SPI_ISR.
If a delayed irq thread runs after cdns_spi_handle_err() finishes, wouldn't
it see CDNS_SPI_IXR_TXOW set and xspi->tx_bytes =3D=3D 0, disable interrupt=
s, and
call spi_finalize_current_transfer() prematurely on the next transfer?

> +	cdns_spi_init_hw(xspi, spi_controller_is_target(ctlr));

[Severity: High]
Does calling cdns_spi_init_hw() in drivers/spi/spi-cadence.c without
resetting xspi->speed_hz leave the bus running at the maximum clock rate on
subsequent transfers?

In host mode, cdns_spi_init_hw() writes CDNS_SPI_CR_DEFAULT to CDNS_SPI_CR,
which resets the hardware baud rate divisor bits (CDNS_SPI_CR_BAUD_DIV) back
to CDNS_SPI_CR_BAUD_DIV_4 (xspi->clk_rate / 4, i.e., ctlr->max_speed_hz):

drivers/spi/spi-cadence.c:cdns_spi_init_hw() {
	if (!is_target)
		ctrl_reg |=3D CDNS_SPI_CR_DEFAULT;
	...
	cdns_spi_write(xspi, CDNS_SPI_CR, ctrl_reg);
}

When the next transfer runs cdns_transfer_one() -> cdns_spi_setup_transfer()
-> cdns_spi_config_clock_freq(), it only reprograms the divisor if
xspi->speed_hz differs from transfer->speed_hz:

drivers/spi/spi-cadence.c:cdns_spi_config_clock_freq() {
	ctrl_reg =3D cdns_spi_read(xspi, CDNS_SPI_CR);

	/* Set the clock frequency */
	if (xspi->speed_hz !=3D transfer->speed_hz) {
		...
		ctrl_reg &=3D ~CDNS_SPI_CR_BAUD_DIV;
		ctrl_reg |=3D baud_rate_val << CDNS_SPI_BAUD_DIV_SHIFT;

		xspi->speed_hz =3D frequency / (2 << baud_rate_val);
	}
	cdns_spi_write(xspi, CDNS_SPI_CR, ctrl_reg);
}

If the next transfer requests the same frequency that was cached in
xspi->speed_hz before the error, won't cdns_spi_config_clock_freq() skip
updating CDNS_SPI_CR_BAUD_DIV and leave the hardware running at clk_rate / 4
instead of the requested speed?

[Severity: Medium]
What happens in target mode if a transfer with xspi->tx_bytes >
xspi->tx_fifo_depth fails while another message is already queued on the
controller?

In drivers/spi/spi-cadence.c, cdns_transfer_one() raises CDNS_SPI_THLD for
large target transfers:

drivers/spi/spi-cadence.c:cdns_transfer_one() {
	if (!spi_controller_is_target(ctlr)) {
		cdns_spi_setup_transfer(spi, transfer);
	} else {
		if (xspi->tx_bytes > xspi->tx_fifo_depth)
			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
	}
}

Normally CDNS_SPI_THLD is reset to 0x1 either in cdns_spi_irq() when
xspi->tx_bytes drops below half the fifo depth or in
cdns_unprepare_transfer_hardware() when the queue becomes idle. Neither
cdns_spi_handle_err() nor cdns_spi_init_hw() resets CDNS_SPI_THLD to 0x1.

If a large target transfer is interrupted in spi_transfer_wait() and another
message is queued behind it, __spi_pump_messages() starts the next message
without calling cdns_unprepare_transfer_hardware(). If the next transfer has
tx_bytes <=3D tx_fifo_depth, should cdns_spi_handle_err() or cdns_spi_init_=
hw()
reset CDNS_SPI_THLD to 0x1 so that CDNS_SPI_IXR_TXOW does not fire
immediately with xspi->tx_bytes =3D=3D 0 and complete the transfer prematur=
ely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105203703.9790=
67-1-mario.behn@gmail.com?part=3D1
